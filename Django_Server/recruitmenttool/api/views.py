# -*- coding: utf-8 -*-
from django.views.decorators.csrf import csrf_exempt
from rest_framework.response import Response
from rest_framework import status
from rest_framework.decorators import api_view
from cdamanager.Evaluations import evaluate_request
from cdamanager.XMLEvaluator import XMLEvaluator
from .database_handler import Database_Handler
from django.utils import timezone
import datetime
import api.models as model
import api.serializers as serializer
import json
now = datetime.datetime.now(tz=timezone.utc)


@csrf_exempt
@api_view(('POST',))
#TODO: RENAME create new study
def create_new_criteria(request):
    if request.method == 'POST':
        r = request.data
        dbhandler = Database_Handler(r)
        study = dbhandler.write_study_in_db()
        if study is not None:
            dbhandler.write_criterium_in_db(study)
            dbhandler.write_information_need_in_db(study)
        else:
            return Response("Fail while creating the study - no name provided?",
                            status=status.HTTP_400_BAD_REQUEST)
        dataList = request.FILES.getlist('file')
        if dataList:
            for file in dataList:
                if XMLEvaluator.evaluate_file_type(str(file)):
                    dbhandler.write_patient_and_CDAData_in_db(file)
        # try:
        #     result = evaluate_request(study.id)
        #     return Response(json.loads(result), status=status.HTTP_201_CREATED)
        # except Exception:
        #     return Response("NO CORRECT INFORMATION PROVIDED" + Exception,
        #                     status=status.HTTP_400_BAD_REQUEST)
        return Response("CREATED", status=status.HTTP_201_CREATED)


@csrf_exempt
@api_view(('GET',))
def create_new_criteria_DEBUG(request):
    result = evaluate_request(221)
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
    #TODO: check if realy not needed anymore
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
