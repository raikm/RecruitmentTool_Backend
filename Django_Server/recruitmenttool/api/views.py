# -*- coding: utf-8 -*-
from django.views.decorators.csrf import csrf_exempt
from rest_framework.response import Response
from rest_framework import status
from rest_framework.decorators import api_view
from .helper import define_boolean, validate_json
from api.serializers import CriteriaSerializer
from .models import Criteria, Criterium, CDAFile, Patient
from cdamanager.Evaluations import Evaluation
from django.utils import timezone
import datetime
import json
import html

now = datetime.datetime.now(tz=timezone.utc)


@csrf_exempt
@api_view(('POST',))
def create_new_criteria(request):
    if request.method == 'POST':
        r = request.data
        try:
            criteria = Criteria.objects.create(name=r.get('Criteria_Name'),
                                               description=r.get('Description'),
                                               date=now,
                                               only_current_patient_cohort=define_boolean(r.get('Only_current_patient_cohort')))

            criterium_list = None #TODO: Refactor ->  global
            criterium_list_str = r.get('Criterium_Names[]')
            if criterium_list_str:
                if validate_json(criterium_list_str):
                    criterium_list = json.loads(criterium_list_str)
                else:
                    return Response("NO VALID JSON",
                                    status=status.HTTP_400_BAD_REQUEST)
            else:
                return Response("NO CORRECT CRITERIA INFORMATION PROVIDED",
                                status=status.HTTP_400_BAD_REQUEST)

            for criterium in criterium_list:
                Criterium.objects.create(name=html.unescape(str(criterium[0])), xPath=html.unescape(str(criterium[1])), criteria=criteria)

            dataList = request.FILES.getlist('file')
            if dataList:
                for file in dataList:
                    # TODO look for patient first of not found create new one
                    patient = Patient.objects.create(title="t",
                                                     first_name="f",
                                                     middle_name="m",
                                                     last_name="l",
                                                     birthdate=now)  # Todo extrahieren von XML

                    CDAFile.objects.create(name="Test",  # Todo save filename
                                           path="Testpath",  # Todo cda_files+name - necessary??
                                           file=file,
                                           file_date=now,  # TODO: get Data from XML
                                           upload_date=now,
                                           patient=patient)

            result = Evaluation.start_evaluation(criteria.id, criteria.name, criteria.only_current_patient_cohort)
            # TODO: return data review from evaluation
            return Response(result, status=status.HTTP_201_CREATED)

        except Exception:
            return Response("NO CORRECT INFORMATION PROVIDED" + Exception,
                            status=status.HTTP_400_BAD_REQUEST)

    return Response(status=status.HTTP_400_BAD_REQUEST)


@csrf_exempt
@api_view(('GET',))
def criteria_detail(request, pk):
    pass
