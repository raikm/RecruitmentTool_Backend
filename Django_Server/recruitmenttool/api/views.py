# -*- coding: utf-8 -*-
import distutils
import glob
import os.path
from os import path
from .models import Patient

from django.core.files.base import ContentFile
from django.http import HttpResponse, JsonResponse
from django.views.decorators.csrf import csrf_exempt
from rest_framework.response import Response
from django.core.files.storage import default_storage, FileSystemStorage
from rest_framework import status
from rest_framework.decorators import api_view
from Django_Server.recruitmenttool.cdamanager.Evaluations import evaluate_request
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
import configparser

configParser = configparser.RawConfigParser()
configFilePath = r'Django_Server/recruitmenttool/config_file.cfg'
configParser.read(configFilePath)


@csrf_exempt
@api_view(('POST',))
def create_or_edit_new_study(request):
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
        #try:
        local_analysis = bool(distutils.util.strtobool(r.get('Local_Analysis')))
        result = evaluate_request(study.id, selected_patient_list, local_analysis)
        #except Exception as e:
        #    print(e)
        #    return Response("NO CORRECT INFORMATION PROVIDED" + str(Exception),
        #                    status=status.HTTP_400_BAD_REQUEST)
        return Response(result, status=status.HTTP_201_CREATED)


@csrf_exempt
@api_view(('GET',))
def all_studies(request):
    study_list = model.Study.objects.all()
    result = []
    for study in study_list:
        data_set = serializer.StudySerializer(study).data
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

    root_tempDownload_path = configParser.get('temp-folders', 'download')
    root_tempCache_path = configParser.get('temp-folders', 'cache')
    cda_file_path = root_tempCache_path + "/" + patient_id + "/" + patient_id + "_" + document_id + ".xml"
    # try to get CDA File from tempDownload Folder
    if not path.exists(cda_file_path):
        cda_file_path = root_tempDownload_path + "/" + patient_id + "/" + patient_id + "_" + document_id + ".xml"
    # try to download CDA Files from Repository
    if not path.exists(cda_file_path):
        gateway = JavaGateway()
        xds_connector = gateway.entry_point
        oid = "1.2.40.0.10.1.4.3.1"
        cda_file_path = xds_connector.queryDocumentWithId(oid, patient_id, document_id)
        gateway.close()
    if cda_file_path == "NO_DOCUMENT_FOUND":
        return Response("NO DOCUMENT FOUND", status=status.HTTP_400_BAD_REQUEST)
    stylesheet_path = configParser.get('xml-to-html-files', 'xsl-file')
    cda_html = CDATransformer.transform_xml_to_xsl(CDATransformer, cda_file_path, stylesheet_path)
    return HttpResponse(cda_html)


@csrf_exempt
@api_view(('POST',))
def prepare_test_data(request):
    gateway = JavaGateway()
    xds_connector = gateway.entry_point
    oid = "1.2.40.0.10.1.4.3.1"
    cda_test_files = glob.glob(
        configParser.get('demo-files', 'cda-files'))
    for file in cda_test_files:
        cda_file = CDAExtractor(file)
        patient_id = cda_file.get_patient_id()
        patient_full_name = cda_file.get_patient_name()
        patient_list = Patient.objects.filter(patient_id = patient_id)
        if patient_list is None or len(patient_list) == 0:
            Patient.objects.create(patient_id=patient_id, patient_first_name=patient_full_name['vornamen'][0],
                                              patient_last_name=patient_full_name['nachname'][0])
        document_id = cda_file.get_document_id()
        cda_exist = xds_connector.validateNewDocument(oid, str(patient_id), str(document_id))
        # TODO: write patient infos into DB
        if cda_exist is False:
            xds_connector.uploadDocument(oid, str(patient_id), str(document_id), "C:/Users/Raik Müller/Documents/GitHub/RecruitmentTool_Backend/"+file)
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
    dbhandler.write_patient_results_in_db()
    delete_cache_files()
    return Response("SELECTED PATIENTS SAVED", status=status.HTTP_201_CREATED)


@csrf_exempt
@api_view(('GET',))
def get_selected_patients(request, study_id):
    r = request.data
    dbhandler = Database_Handler(r)
    selected_patients = dbhandler.get_selected_patients(study_id)
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