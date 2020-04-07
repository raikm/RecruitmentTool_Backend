from rest_framework import viewsets
from django.views.decorators.csrf import csrf_exempt
from rest_framework.response import Response
from rest_framework import status
from rest_framework.decorators import api_view, renderer_classes
from rest_framework.renderers import JSONRenderer, TemplateHTMLRenderer
from .serializers import CriteriaSerializer, CriteriumSerializer
from .helper import handle_uploaded_file, define_boolean
from recruitmenttool.models import Criteria, Criterium, CDAFile, Patient


import datetime

@csrf_exempt
@api_view(('POST',))
def create_new_criteria(request):
    if request.method == 'POST':
        r = request.data

        try:
            criteria = Criteria.objects.create( name=r.get('Criteria_Name'),
                                                description=r.get('Description'),
                                                date=datetime.datetime.utcnow(),
                                                only_current_patient_cohort=define_boolean(r.get('Only_current_patient_cohort')))

            #Todo: loop
            Criterium.objects.create(           name=r.get('Criterium_Name'),
                                                xPath=r.get('xPath'),
                                                criteria=criteria)
            criteria_serializer = CriteriaSerializer(instance=criteria)
            dataList = request.FILES.getlist('file')
            #TODO: File muss nicht gegeben sein
            if dataList:
                for file in dataList:
                    #TODO look for patient first of not found create new one
                    patient = Patient.objects.create(   title="t",
                                                        first_name="f",
                                                        middle_name="m",
                                                        last_name="l",
                                                        birthdate=datetime.datetime.utcnow())#Todo extrahieren von XML


                    cda_file = CDAFile.objects.create(  name="Test",#Todo save filename
                                                        path="Testpath",#Todo cda_files+name
                                                        file=file,
                                                        file_date=datetime.datetime.utcnow(),#TODO: get Data from XML
                                                        upload_date=datetime.datetime.utcnow(),
                                                        patient=patient)


                    return Response("CREATED", status=status.HTTP_201_CREATED)
            # else:
            #     return Response("NO FILES PROVIDED", status=status.HTTP_400_BAD_REQUEST)
            return Response("CREATED", status=status.HTTP_201_CREATED)
        except:
            return Response("NO CORRECT INFORMATION PROVIDED", status=status.HTTP_400_BAD_REQUEST)

    return Response(status=status.HTTP_400_BAD_REQUEST)


@csrf_exempt
@api_view(('GET',))
def criteria_detail(request, pk):
    pass
