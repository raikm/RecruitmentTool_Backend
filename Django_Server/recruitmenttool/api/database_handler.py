# -*- coding: utf-8 -*-
from django.core.files.storage import default_storage
from py4j.java_gateway import JavaGateway

from .models import Study, Criterion, Condition, Information_Need, Patient
from cdamanager.CDAExtractor import CDAExtractor
from api.helper import validate_json
import datetime
import json
import html
from cdamanager.XMLEvaluator import XMLEvaluator
import api.serializers as serializer


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

    def write_criterion_in_db(self, study):
        global criterion_list
        criterion_list_str = self.request.get('Criterions[]')
        if criterion_list_str and criterion_list_str != "[]":
            if validate_json(criterion_list_str):
                criterion_list = json.loads(criterion_list_str)
            else:
                print("----------No valide criterium-json----------")
        else:
            print("----------Error while parsing criterion_list_str----------")

        for criterion in criterion_list:
            try:
                criterion_object = Criterion.objects.create(criterion_type=html.unescape(criterion['criterion_type']), name=html.unescape(criterion['name']), study=study)
                conditions = criterion['conditions']

                for c in conditions:
                    Condition.objects.create(name=html.unescape(c['conditionName']), xpath=html.unescape(c['condtionXpath']), negative_xpath=html.unescape(c['condtionNegativeXpath']), rough_xpath=html.unescape(c['roughXpath']), criterion=criterion_object)
            except:
                 print("----------Error while creating criterion object or condition----------")

    def write_information_need_in_db(self, study):
        information_need_list = None
        information_need_list_str = self.request.get('Information_Needs[]')
        if information_need_list_str and information_need_list_str != "[]":
            if validate_json(information_need_list_str):
                information_need_list = json.loads(information_need_list_str)
            else:
                print("----------No valide information-need-json----------")

        for information_need in information_need_list:
            try:
                Information_Need.objects.create(name=html.unescape(information_need['informationName']), xPath=html.unescape(information_need['informationXPath']), study=study)
            except:
                 print("----------Error while creating information need object----------")

    # def write_patient_and_CDAData_in_db(self, file):
    #     extractor = CDAExtractor(file)
    #     patient_id_from_cda = extractor.get_patient_id()
    #     patient_list = Patient.objects.filter(patient_id = patient_id_from_cda)
    #     patient = None
    #     if patient_list is None or len(patient_list) == 0:
    #         patientfullname = extractor.get_patient_name()
    #         try:
    #             patient = Patient.objects.create(title="", #TODO add title
    #                                           first_name=patientfullname['vornamen'][0],
    #                                           middle_names= patientfullname['vornamen'][1],
    #                                           last_name= patientfullname['nachname'][0],
    #                                           birthdate=extractor.get_birthTime(),
    #                                           patient_id=patient_id_from_cda)
    #         except:
    #             print("----------Error while creating Patient Object----------")
    #     else:
    #         # if patient already exist
    #         patient = patient_list[0]
    #
    #     cda_id = extractor.get_document_id()
    #     cda_list = CDAFile.objects.filter(cda_id = cda_id)
    #     if cda_list is None or len(cda_list) == 0:
    #         CDAFile.objects.create(  name=str(file),
    #                                  cda_id=cda_id,
    #                                  file=file,
    #                                  file_date=extractor.get_date_created(),
    #                                  upload_date=now,
    #                                  patient=patient)
    #     else:
    #
    #         print("----------CDA File exist already - no db-save----------")
    #     del extractor
    def save_cda_files_in_xds(self, file_list):
        gateway = JavaGateway()
        xds_connector = gateway.entry_point
        oid = "1.2.40.0.10.1.4.3.1"
        root_temp_upload_path = "C:/Users/Raik Müller/Documents/GitHub/RecruitmentTool_Backend/Django_Server/recruitmenttool/cda_files/tempUpload/"
        result = []
        for file in file_list:
            if XMLEvaluator.evaluate_file_type(XMLEvaluator, file):
                cda_file = CDAExtractor(file)
                patient_id = cda_file.get_patient_id()
                patient_full_name = cda_file.get_patient_name()
                if not any(obj['patient_id'] == patient_id for obj in result):
                    result.append(self.create_patient_list(self, patient_id, patient_full_name))

                patient_list = Patient.objects.filter(patient_id = patient_id, patient_first_name = patient_full_name['vornamen'][0], patient_last_name = patient_full_name['nachname'][0])
                if patient_list is None or len(patient_list) == 0:
                    Patient.objects.create(patient_id=patient_id, patient_first_name=patient_full_name['vornamen'][0],
                                                      patient_last_name=patient_full_name['nachname'][0])
                document_id = cda_file.get_document_id()
                cda_exist = xds_connector.validateNewDocument(oid, str(patient_id), str(document_id))
                # TODO: write patient infos into DB
                if cda_exist is False:
                    file_name = str(patient_id) + '_' + str(document_id) + '.xml'
                    default_storage.save("Django_Server/recruitmenttool/cda_files/tempUpload/" + file_name, file)
                    xds_connector.uploadDocument(oid, str(patient_id), str(document_id),
                                                 root_temp_upload_path + file_name)
        gateway.close()
        return result

    def save_cda_files_in_cache(self, file_list):
        result = []
        for file in file_list:
            if XMLEvaluator.evaluate_file_type(XMLEvaluator, file):
                cda_file = CDAExtractor(file)
                patient_id = cda_file.get_patient_id()
                patient_full_name = cda_file.get_patient_name()
                if not any(obj['patient_id'] == patient_id for obj in result):
                    result.append(self.create_patient_list(self, patient_id, patient_full_name))
                patient_list = Patient.objects.filter(patient_id=patient_id)
                if patient_list is None or len(patient_list) == 0:
                    Patient.objects.create(patient_id=patient_id, patient_first_name=patient_full_name['vornamen'][0],
                                                      patient_last_name=patient_full_name['nachname'][0])
                document_id = cda_file.get_document_id()
                file_name = str(patient_id) + '_' + str(document_id) + '.xml'
                default_storage.save("Django_Server/recruitmenttool/cda_files/tempCache/" + str(patient_id) + "/" + file_name, file)
        return result

    def write_selected_patients_in_db(self):
        try:
            selected_patient_list_str = self.request.get('Selected_Patients[]')
            study_id = self.request.get('Study_Id')
            selected_patient_list = []
            if selected_patient_list_str and selected_patient_list_str != "[]":
                if validate_json(selected_patient_list_str):
                    selected_patient_list = json.loads(selected_patient_list_str)
            study = Study.objects.filter(id=study_id).first()
            for patient_id in selected_patient_list:
                p = Patient.objects.filter(patient_id=patient_id).first()
                p.studies.add(study)
        except Exception as e:
            print(e)
            print("----------Error while creating SelectedPatient Object----------")


    def get_selected_patients(self, request, study_id):
        try:
            study = Study.objects.filter(id=study_id).first()
            selected_patients_study = list(Patient.objects.filter(studies=study).all())
            result = []

            for patient in selected_patients_study:
                patient_result = serializer.PatientSerializer(patient).data
                #TODO: could be optimzed if all the clutter from the study object is removed
                result.append(patient_result)

            return result
        except Exception as e:
            print(e)
            print("----------Error while creating SelectedPatient Object----------")


    def create_patient_list(self, patient_id, patient_full_name):
            patient_first_name = patient_full_name['vornamen'][0]
            patient_last_name = patient_full_name['nachname'][0]
            return {"patient_id": patient_id, "patient_first_name": patient_first_name,
                              "patient_last_name": patient_last_name}

