# -*- coding: utf-8 -*-
import glob
import os.path
from os import path

from django.core.files.base import ContentFile
from django.http import HttpResponse
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

import api.models as model
import api.serializers as serializer
from cdamanager.CDATransformer import CDATransformer
from cdamanager.CDAExtractor import CDAExtractor
import json
from py4j.java_gateway import JavaGateway


now = datetime.datetime.now(tz=timezone.utc)


@csrf_exempt
@api_view(('POST',))
def create_and_validate_new_study(request):
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
        file_list = request.FILES.getlist('file')
        if file_list:
            Database_Handler.save_cda_files_in_xds(Database_Handler, file_list)
        try:
            result = evaluate_request(study.id)
        except Exception:
            return Response("NO CORRECT INFORMATION PROVIDED" + Exception,
                            status=status.HTTP_400_BAD_REQUEST)
        return Response(json.loads(result), status=status.HTTP_201_CREATED)


@csrf_exempt
@api_view(('POST',))
def validate_saved_criteria(request):
    if request.method == 'POST':
        r = request.data
        study_name = r.get('Study_Name') # TODO: later Ethicsnumber for identification
        #study_name = "NVC Glaukom Studie"
        study = model.Study.objects.all().filter(name=study_name)[0]

        file_list = request.FILES.getlist('file')
        if file_list:
            Database_Handler.save_cda_files_in_xds(file_list)
        try:
            result = evaluate_request(study.id)
        except:
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
    # TODO: check if realy not needed anymore
    # critierum_list_db = model.Criterium.objects.all().filter(study_id=study_id)
    # if len(critierum_list_db) == 0:
    #     return Response("Incompleted Data in DB",
    #                     status=status.HTTP_400_BAD_REQUEST)

    # critierum_list = []
    # for c in critierum_list_db:
    #     criterium = serializer.CriteriumSerializer(c)
    #     print(criterium.data)
    #     print("---------------------------------")
    #     critierum_list.append(criterium.data)

    # criterium_id = critierum_list[0].id
    # condition_list = model.Condition.objects.all().filter(criterium_id=criterium_id)
    # information_needed_list = model.Information_Need.objects.all().filter(study_id=study_id)
    # print(critierum_list)
    result = []
    # data_set = {"Study_ID": study.id, "Study_Name": study.name, "Criterias": critierum_list}
    # result.append(data_set)
    result.append(study_serialized)
    return Response(result, status=status.HTTP_200_OK)


@csrf_exempt
@api_view(('GET',))
def get_visualized_cda(request, patient_id, document_id):
    # cda_file = model.CDAFile.objects.all().filter(cda_id=1234567.1).first()
    gateway = JavaGateway()
    xds_connector = gateway.entry_point
    oid = "1.2.40.0.10.1.4.3.1"
    root_path = "C:/Users/Raik Müller/Documents/GitHub/RecruitmentTool_Backend/Django_Server/recruitmenttool/cda_files/tempDownload"
    cda_file_path = root_path + "/" +  patient_id + "/" + document_id + "_" + patient_id + ".xml"
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
