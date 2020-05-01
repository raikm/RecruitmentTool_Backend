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
import json

now = datetime.datetime.now(tz=timezone.utc)


@csrf_exempt
@api_view(('POST',))
def create_new_criteria(request):
    if request.method == 'POST':
        r = request.data
        dbhandler = Database_Handler(r)
        criteria = dbhandler.write_criteria_in_db()
        if criteria is not None:
            dbhandler.write_criterium_in_db(criteria)
        else:
            return Response("Fail while creating the criteria/study - no name provided?",
                            status=status.HTTP_400_BAD_REQUEST)

        dataList = request.FILES.getlist('file')
        if dataList:
            for file in dataList:
                if XMLEvaluator.evaluate_file_type(str(file)):
                    dbhandler.write_patient_and_CDAData_in_db(file)
        try:
            result = evaluate_request(criteria.id)
            return Response(json.loads(result), status=status.HTTP_201_CREATED)
        except Exception:
            return Response("NO CORRECT INFORMATION PROVIDED" + Exception,
                            status=status.HTTP_400_BAD_REQUEST)
        return Response("", status=status.HTTP_400_BAD_REQUEST)


@csrf_exempt
@api_view(('POST',))
def create_new_criteria_DEBUG(request):
    print("done")
    result = """{"patients": [{"patient_id": 1111241261, "patient_first_name": "Herbert", "patient_middle_names": "Hannes", "patient_last_name": "Mustermann", "birthTime": "1961-12-24", "results": [{"criterum_id": 348, "criterum_name": "Test", "evaluation_result": true, "evaluation_result_text": "match", "evaluation_related_cda": 1234567.1}]}]}"""
    # result = json.loads(_result)
    return Response(result, status=status.HTTP_201_CREATED)


@csrf_exempt
@api_view(('GET',))
def criteria_detail(request, pk):
    pass
