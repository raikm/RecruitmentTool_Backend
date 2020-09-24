# -*- coding: utf-8 -*-
from Django_Server.recruitmenttool.cdamanager.CDAExtractor import CDAExtractor
from Django_Server.recruitmenttool.api.models import Study, Criterium, Condition, CDAFile, Patient, Information_Need
from Django_Server.recruitmenttool.api.helper import validate_json
import datetime
import json
import html
now = datetime.datetime.now()


class Database_Handler:

    def __init__(self, request):
        self.request = request
        # self.file = file
        # self.extractor = CDAExtractor(self.file)

    def write_study_in_db(self):
        try:
            study = Study.objects.create(name=self.request.get('Study_Name'),
                                               description=self.request.get(
                                                   'Description'),
                                               date=now,
                                               only_current_patient_cohort=True)
            return study
        except:
            print("----------Error while creating Study Object----------")

    def write_criterium_in_db(self, study):
        global criterium_list
        criterium_list_str = self.request.get('Criterias[]')
        if criterium_list_str and criterium_list_str != "[]":
            if validate_json(criterium_list_str):
                criterium_list = json.loads(criterium_list_str)
            else:
                print("----------No valide criterium-json----------")
        else:
            print("----------Error while parsing criterium_list_str----------")

        for criterium in criterium_list:
            try:
                criterium_object = Criterium.objects.create(criterium_type=html.unescape(criterium['criteria_type']), name=html.unescape(criterium['name']), study=study)
                conditions = criterium['conditions']

                for c in conditions:
                    Condition.objects.create(name=html.unescape(c['conditionName']), xPath=html.unescape(c['condtionxPath']), value_xPath=html.unescape(c['valuexPath']), criterium=criterium_object)
            except:
                 print("----------Error while creating criterium object or condition----------")

    def write_information_need_in_db(self, study):
        global information_need_list
        information_need_list_str = self.request.get('Information_Needs[]')
        if information_need_list_str and information_need_list_str != "[]":
            if validate_json(information_need_list_str):
                information_need_list = json.loads(information_need_list_str)
            else:
                print("----------No valide information-need-json----------")
        else:
            print("----------Error while parsing information_need_list_str----------")

        for information_need in information_need_list:
            try:
                Information_Need.objects.create(name=html.unescape(information_need['informationName']), xPath=html.unescape(information_need['informationXPath']), study=study)
            except:
                 print("----------Error while creating information need object----------")

    def write_patient_and_CDAData_in_db(self, file):
        extractor = CDAExtractor(file)
        patient_id_from_cda = extractor.get_patient_id()
        patient_list = Patient.objects.filter(patient_id = patient_id_from_cda)
        patient = None
        if patient_list is None or len(patient_list) == 0:
            patientfullname = extractor.get_patient_name()
            try:
                patient = Patient.objects.create(title="", #TODO add title
                                              first_name=patientfullname['vornamen'][0],
                                              middle_names= patientfullname['vornamen'][1],
                                              last_name= patientfullname['nachname'][0],
                                              birthdate=extractor.get_birthTime(),
                                              patient_id=patient_id_from_cda)
            except:
                print("----------Error while creating Patient Object----------")
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

            print("----------CDA File exist already - no db-save----------")
        del extractor
