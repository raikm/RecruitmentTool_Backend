# -*- coding: utf-8 -*-
from django.views.decorators.csrf import csrf_exempt
from rest_framework.response import Response
from rest_framework import status
from rest_framework.decorators import api_view
from .helper import define_boolean, validate_json
# from api.serializers import CriteriaSerializer
from .models import Criteria, Criterium, CDAFile, Patient
from cdamanager.Evaluations import Evaluation
from cdamanager.CDAExtractor import CDAExtractor
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
            if criterium_list_str and criterium_list_str != "[]":
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
                    extractor = CDAExtractor(file)
                    # TODO: auslagern in evaluator
                    patient_id_from_cda = extractor.get_patient_id()
                    patient_list = Patient.objects.filter(patient_id = patient_id_from_cda)
                    patient = None
                    if patient_list is None or len(patient_list) == 0:
                        patientfullname = extractor.get_patient_name()

                        patient = Patient.objects.create(title="", #TODO add title
                                                        first_name=patientfullname['vornamen'][0],
                                                        middle_names= patientfullname['vornamen'][1],
                                                        last_name= patientfullname['nachname'][0],
                                                        birthdate=extractor.get_birthTime(),
                                                        patient_id=patient_id_from_cda)  # Todo extrahieren von XML
                    else:
                        patient = patient_list[0]

                    # TODO: auslagern in evaluator
                    cda_id = extractor.get_cda_id()
                    cda_list = CDAFile.objects.filter(cda_id = cda_id)
                    if cda_list is None or len(cda_list) == 0:
                        CDAFile.objects.create(name=str(file),
                                               cda_id=cda_id,
                                               file=file,
                                               file_date=extractor.get_date_created(),
                                               upload_date=now,
                                               patient=patient)
                    else:
                        print("CDA File exist already")

                    del extractor
            result = Evaluation.start_evaluation(criteria.id)
            return Response(result, status=status.HTTP_201_CREATED)

        except Exception:
            return Response("NO CORRECT INFORMATION PROVIDED" + Exception,
                            status=status.HTTP_400_BAD_REQUEST)

    return Response(status=status.HTTP_400_BAD_REQUEST)


@csrf_exempt
@api_view(('GET',))
def criteria_detail(request, pk):
    pass
