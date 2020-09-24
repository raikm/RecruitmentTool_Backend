import glob

import api.models as model
from py4j.java_gateway import JavaGateway

from .CDAEvaluator import CDAEvaluator as evaluator
from .CDAExtractor import CDAExtractor
import json
import api.serializers as serializer

SATISFIED = "SATISFIED"
NOT_SATISFIED = "NOT_SATISFIED"
NO_DATA = "NO_DATA"
ERROR = "ERROR"
hit_counter = 0


def evaluate_request(id):
    critierum_list = model.Criterium.objects.all().filter(study_id=id)
    information_need_list = model.Information_Need.objects.all().filter(study_id=id)
    patient_list = model.Patient.objects.all()
    if len(patient_list) == 0: raise Exception("No Patients in DB found")
    patients_dic = {}
    patients_dic["patients"] = []

    for patient in patient_list:
        global hit_counter
        hit_counter = 0
        patient_result = get_patient(patient)
        patient_result["criterium_results"] = evaluate_criterions(critierum_list, patient)
        patient_result["criterium_results_overview"] = hit_counter
        patient_result["information_needed_results"] = {}#evaluate_information_need(information_need_list, patient)
        patients_dic["patients"].append(patient_result)

    return patients_dic


def get_patient(patient):
    return serializer.PatientSerializer(patient).data


def get_condtion(condition):
    return serializer.ConditionSerializer(condition).data


def evaluate_criterions(critierum_list, patient):
    patient_cda_files = download_all_files_from_patient(str(patient.patient_id))


    criterium_results = []
    for criterium in critierum_list:
        criterium_result = {}
        criterium_result["name"] = criterium.name
        criterium_result["criterium_type"] = criterium.criterium_type
        criterium_result["conditions"] = []

        conditions = model.Condition.objects.all().filter(criterium_id=criterium.id)
        hit_watch = False
        for condition in conditions:
            condition_result = {}
            condition_result["name"] = condition.name

            evaluation_results = {}
            evaluation_results["hits"] = []
            value_results = {}
            value_results["values"] = []

            # TODO: order patient_cda_files by date
            for file in patient_cda_files:
                cda_file = CDAExtractor(file)
                evaluation_result = evaluator.evaluate_cda_file_Etree(evaluator, condition.xPath, file)
                values_result = evaluator.evaluate_cda_file_Etree(evaluator, condition.value_xPath, file)
                # TODO: negative_evaluation_result
                # TODO: !!!!!!delete temp file
                if len(evaluation_result) > 0:
                    hit = {"hit_result": evaluation_result, "cda_id": cda_file.get_cda_id()}
                    evaluation_results["hits"].append(hit)
                    evaluation_results["evaluation_result_summary"] = "hit"
                    hit_watch = True
                if len(values_result) > 0:
                    value_result = {"value_result": values_result, "cda_id": cda_file.get_cda_id()}
                    value_results["values"].append(value_result)
                continue
            if len(evaluation_results["hits"]) == 0:
                evaluation_results["hits"] = []
                evaluation_results["value_results"] = value_results
                evaluation_results["evaluation_result_summary"] = "no_hit"

            condition_result["evaluation_results"] = evaluation_results
            criterium_result["conditions"].append(condition_result)
            if hit_watch:
                global hit_counter
                hit_counter = hit_counter + 1
            criterium_result["criterium_summary_result"] = "hit" if hit_watch else "no_hit"

        # TODO: change if negative xPaths are implemented

        criterium_results.append(criterium_result)

    return criterium_results


def evaluate_information_need(information_need_list, patient):
    information_need_results = []
    for information in information_need_list:
        information_result = {}
        information_result["name"] = information.name
        patient_cda_files = model.CDAFile.objects.all().filter(patient_id=patient.id)

        evaluation_related_cda = None
        values_result = []
        for file in patient_cda_files:
            values_result = evaluator.evaluate_cda_file_Etree(evaluator, information.xPath, file.file)
            if len(values_result) == 0:
                continue
            evaluation_related_cda = file.cda_id
            break

        information_result["values_result"] = values_result
        information_result["values_related_cda"] = evaluation_related_cda
        information_need_results.append(information_result)

    return information_need_results


def download_all_files_from_patient(patient_id):
    # download all file from XDS
    #TODO: check if cda is already in temp = cache
    gateway = JavaGateway()
    xds_connector = gateway.entry_point
    oid = "1.2.40.0.10.1.4.3.1"
    print(oid + " " + str(patient_id))
    xds_connector.downloadPatientFiles(oid, patient_id)
    gateway.close()
    # get all cda files from tempDownload
    return glob.glob(
        "C:/Users/Raik Müller/Documents/GitHub/RecruitmentTool_Backend/Django_Server/recruitmenttool/cda_files/tempDownload/*.xml")