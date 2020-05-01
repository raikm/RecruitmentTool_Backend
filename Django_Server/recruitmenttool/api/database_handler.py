# -*- coding: utf-8 -*-
from cdamanager.CDAExtractor import CDAExtractor
from .models import Criteria, Criterium, CDAFile, Patient
from .helper import define_boolean, validate_json
import datetime
import json
import html
import sys


now = datetime.datetime.now()

class Database_Handler:

    def __init__(self, request):
        self.request = request
        # self.file = file
        # self.extractor = CDAExtractor(self.file)

    def write_criteria_in_db(self):
        try:
            criteria = Criteria.objects.create(name=self.request.get('Criteria_Name'),
                                               description=self.request.get(
                                                   'Description'),
                                               date=now,
                                               only_current_patient_cohort=False) #BUGFIX
            return criteria
        except:
            return None

    def write_criterium_in_db(self, criteria):
        global criterium_list
        criterium_list_str = self.request.get('Criterium_Names[]')
        if criterium_list_str and criterium_list_str != "[]":
            if validate_json(criterium_list_str):
                criterium_list = json.loads(criterium_list_str)
            else:
                print("Error whilte validating json")
        else:
            print("Error while parsing criterium_list")

        for criterium in criterium_list:
            try:
                Criterium.objects.create(name=html.unescape(str(criterium[0])), xPath=html.unescape(str(criterium[1])), criteria=criteria)
            except:
                print("Error while creating criterium object")

    def write_patient_and_CDAData_in_db(self, file):
        extractor = CDAExtractor(file)
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
                                          patient_id=patient_id_from_cda)
        else:
            # if patient already exist
            patient = patient_list[0]
        cda_id = extractor.get_cda_id()
        cda_list = CDAFile.objects.filter(cda_id = cda_id)
        if cda_list is None or len(cda_list) == 0:
            CDAFile.objects.create(  name=str(file),
                                     cda_id=cda_id,
                                     file=file,
                                     file_date=extractor.get_date_created(),
                                     upload_date=now,
                                     patient=patient)
        else:
            print("CDA File exist already")
        del extractor
