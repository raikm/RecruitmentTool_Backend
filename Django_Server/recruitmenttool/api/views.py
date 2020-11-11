# -*- coding: utf-8 -*-
import distutils
import glob
import os.path
from os import path

from django.core.files.base import ContentFile
from django.http import HttpResponse, JsonResponse
from django.views.decorators.csrf import csrf_exempt
from rest_framework.response import Response
from django.core.files.storage import default_storage, FileSystemStorage
from rest_framework import status
from rest_framework.decorators import api_view
from cdamanager.Evaluations import evaluate_request
from cdamanager.XMLEvaluator import XMLEvaluator
from api.database_handler import Database_Handler
from django.utils import timezone
import datetime
from api.helper import validate_json, delete_cache_files
import api.models as model
import api.serializers as serializer
from cdamanager.CDATransformer import CDATransformer
from cdamanager.CDAExtractor import CDAExtractor
import json
from py4j.java_gateway import JavaGateway
from distutils import util


import html

now = datetime.datetime.now(tz=timezone.utc)


@csrf_exempt
@api_view(('POST',))
def create_new_study(request):
    if request.method == 'POST':
        r = request.data
        dbhandler = Database_Handler(r)
        study = dbhandler.write_study_in_db()
        if study is not None:
            dbhandler.write_criterion_in_db(study)
            dbhandler.write_information_need_in_db(study)
        else:
            return Response("Fail while creating the study - no study name provided?",
                            status=status.HTTP_400_BAD_REQUEST)

        return Response("STUDY CREATED", status=status.HTTP_201_CREATED)


@csrf_exempt
@api_view(('POST',))
def validate_saved_criteria(request):
    if request.method == 'POST':
        r = request.data
        study_name = r.get('Study_Name') # TODO: later Ethicsnumber for identification
        #study_name = "NVC Glaukom Studie"
        study = model.Study.objects.all().filter(name=study_name)[0]

        selected_patient_list_str = r.get('Selected_Patients[]')
        if selected_patient_list_str and selected_patient_list_str != "[]":
            if validate_json(selected_patient_list_str):
                selected_patient_list = json.loads(selected_patient_list_str)
            else:
                print("----------No valide selected patient-json----------")
        try:
            local_analysis = bool(distutils.util.strtobool(r.get('Local_Analysis')))
            result = evaluate_request(study.id, selected_patient_list, local_analysis)
        except Exception as e:
            print(e)
            return Response("NO CORRECT INFORMATION PROVIDED" + str(Exception),
                            status=status.HTTP_400_BAD_REQUEST)
        return Response(result, status=status.HTTP_201_CREATED)


@csrf_exempt
@api_view(('GET',))
def all_studies(request):
    study_list = model.Study.objects.all()
    result = []
    for study in study_list:
        data_set = {"Study_ID": study.id, "Study_Name": study.name}
        result.append(data_set)
    return Response(result, status=status.HTTP_200_OK)


@csrf_exempt
@api_view(('GET',))
def get_study(request, study_id):
    study = model.Study.objects.all().filter(id=study_id).first()
    study_serialized = serializer.StudySerializer(study).data

    return JsonResponse(study_serialized, status=status.HTTP_200_OK)


@csrf_exempt
@api_view(('GET',))
def get_visualized_cda(request, patient_id, document_id):
    # cda_file = model.CDAFile.objects.all().filter(cda_id=1234567.1).first()
    gateway = JavaGateway()
    xds_connector = gateway.entry_point
    oid = "1.2.40.0.10.1.4.3.1"
    root_path = "C:/Users/Raik Müller/Documents/GitHub/RecruitmentTool_Backend/Django_Server/recruitmenttool/cda_files/tempDownload"
    cda_file_path = root_path + "/" +  patient_id + "/" + document_id + "_" + patient_id + ".xml"
    #TODO: handle cache files
    if not path.exists(cda_file_path):
        cda_file_path = xds_connector.queryDocumentWithId(oid, patient_id, document_id)
    if cda_file_path == "NO_DOCUMENT_FOUND":
        return Response("NO DOCUMENT FOUND", status=status.HTTP_400_BAD_REQUEST)
    stylesheet_path = """C:/Users/Raik Müller/Documents/GitHub/RecruitmentTool_Backend/Django_Server/recruitmenttool/cdamanager/Ressources/ELGA_Referenzstylesheet_1.09.001/ELGA_Stylesheet_v1.0.xsl"""
    html = CDATransformer.transform_xml_to_xsl(CDATransformer, cda_file_path, stylesheet_path)
    # TODO: make temp-directory empty
    gateway.close()
    return HttpResponse(html)


@csrf_exempt
@api_view(('POST',))
def prepare_test_data(request):
    gateway = JavaGateway()
    xds_connector = gateway.entry_point
    cda_test_files = glob.glob("C:/Users/Raik Müller/Documents/GitHub/RecruitmentTool_Backend/Django_Server/recruitmenttool/cda_files/*.xml")
    oid = "1.2.40.0.10.1.4.3.1"
    for cda_test_file in cda_test_files:
        cda_file = CDAExtractor(cda_test_file)
        patient_id = cda_file.get_patient_id()
        document_id = cda_file.get_document_id()
        cda_exist = xds_connector.validateNewDocument(oid, str(patient_id), str(document_id))
        if cda_exist is False:
            xds_connector.uploadDocument(oid, str(patient_id), str(document_id), cda_test_file)

    gateway.close()
    return Response("TEST DATA UPLAODED", status=status.HTTP_201_CREATED)


@csrf_exempt
@api_view(('GET',))
def get_patients(request):
    patient_list = model.Patient.objects.all()
    result = []
    for patient in patient_list:
        patient_result = serializer.PatientSerializer(patient).data
        result.append(patient_result)

    return Response(result, status=status.HTTP_200_OK)


@csrf_exempt
@api_view(('POST',))
def save_selected_patients(request):
    r = request.data
    dbhandler = Database_Handler(r)
    dbhandler.write_selected_patients_in_db()
    delete_cache_files()
    return Response("SELECTED PATIENTS SAVED", status=status.HTTP_201_CREATED)


@csrf_exempt
@api_view(('POST',))
def update_selected_patients(request):
    r = request.data
    dbhandler = Database_Handler(r)
    dbhandler.update_selected_patients_in_db()
    return Response("SELECTED PATIENTS UPDATED", status=status.HTTP_201_CREATED)


@csrf_exempt
@api_view(('GET',))
def get_selected_patients(request, study_id):
    r = request.data
    dbhandler = Database_Handler(r)
    selected_patients = dbhandler.get_selected_patients(request, study_id)
    return JsonResponse(selected_patients, safe=False, status=status.HTTP_200_OK)


@csrf_exempt
@api_view(('POST',))
def validate_selected_cda_files(request):
    r = request.data
    file_list = request.FILES.getlist('file')
    repository_save = bool(distutils.util.strtobool(r.get('Repository_Save')))
    if file_list and repository_save:
        result = Database_Handler.save_cda_files_in_xds(Database_Handler, file_list)
    elif file_list and repository_save is False:
        result = Database_Handler.save_cda_files_in_cache(Database_Handler, file_list)
    return JsonResponse(result, safe=False, status=status.HTTP_200_OK)