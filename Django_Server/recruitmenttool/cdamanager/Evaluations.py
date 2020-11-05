import glob

import api.models as model
from py4j.java_gateway import JavaGateway
import json
from .CDAEvaluator import CDAEvaluator as evaluator
from .CDAExtractor import CDAExtractor
import api.serializers as serializer
from collections import Counter

SATISFIED = "SATISFIED"
NOT_SATISFIED = "NOT_SATISFIED"
NO_DATA = "NO_DATA"
ERROR = "ERROR"
hit_counter_ek = 0
hit_counter_ek_negative = 0
hit_counter_ak = 0
hit_counter_ak_negative = 0



def evaluate_request(id, selected_patient_list, local_analysis):
    criterion_list = model.Criterion.objects.all().filter(study_id=id)
    ek_total = len(model.Criterion.objects.all().filter(study_id=id, criterion_type="EK"))
    ak_total = len(model.Criterion.objects.all().filter(study_id=id, criterion_type="AK"))
    information_need_list = model.Information_Need.objects.all().filter(study_id=id)
    if len(selected_patient_list) == 0: raise Exception("No Patients in DB found")
    result_dic = {"patients": [], "study_id": id}

    for patient in selected_patient_list:
        global hit_counter_ek
        global hit_counter_ek_negative
        global hit_counter_ak
        global hit_counter_ak_negative
        hit_counter_ek = 0
        hit_counter_ek_negative = 0
        hit_counter_ak = 0
        hit_counter_ak_negative = 0
        patient_result = get_patient(str(patient['patient_id']))
        patient_result["criterion_results"] = evaluate_criterions(criterion_list, patient, local_analysis)
        patient_result["criterion_results_overview_ic"] = str(hit_counter_ek)
        patient_result["criterion_results_overview_ic_negative"] = str(hit_counter_ek_negative)
        patient_result["criterion_results_overview_ic_no_data"] = str(ek_total - hit_counter_ek - hit_counter_ek_negative)
        patient_result["criterion_results_overview_ec"] = str(hit_counter_ak)
        patient_result["criterion_results_overview_ec_negative"] = str(hit_counter_ak_negative)
        patient_result["criterion_results_overview_ec_no_data"] = str(ak_total - hit_counter_ak - hit_counter_ak_negative)
        patient_result["information_needed_results"] = {}  # evaluate_information_need(information_need_list, patient)
        result_dic["patients"].append(patient_result)

    return result_dic


def get_patient(patient_id):
    patient_cda_files = glob.glob(
        "C:/Users/Raik Müller/Documents/GitHub/RecruitmentTool_Backend/Django_Server/recruitmenttool/cda_files/tempDownload/" + str(
            patient_id) + "/*.xml")
    if patient_cda_files is not None and len(patient_cda_files) != 0:
        patient_cda_file = CDAExtractor(patient_cda_files[0]);
        patient_details = {"patient_id": patient_cda_file.get_patient_id(),
                           "birthdate": patient_cda_file.get_birthTime(),
                           "first_name": patient_cda_file.get_patient_name()["vornamen"][0],
                           "last_name": patient_cda_file.get_patient_name()["nachname"][0], "title": ""}
        return patient_details
    return None


def get_condtion(condition):
    return serializer.ConditionSerializer(condition).data


def evaluate_criterions(criterion_list, patient, local_analysis):

    if local_analysis is False:
        patient_file_paths = download_all_files_from_patient(str(patient['patient_id']))
    else:
        patient_file_paths = get_cache_files(str(patient['patient_id']))
    criterion_results = []
    for criterion in criterion_list:
        criterion_result = {"name": criterion.name, "criterion_type": criterion.criterion_type, "conditions": []}
        conditions = model.Condition.objects.all().filter(criterion_id=criterion.id)
        for condition in conditions:
            condition_result = {"name": condition.name}

            evaluation_results = {"positive_hits": [], "negative_hits": []}
            value_results = {"values": []}

            # TODO: check if works: order patient_cda_files by date
            patient_file_paths.sort(key=lambda fp: CDAExtractor(fp).get_date_created(), reverse=True)
            for file_path in patient_file_paths:
                xml_file = CDAExtractor(file_path)
                # sollte von alt nach neu abfragen, sodass neuste = evaluation_result_summary

                evaluation_result = evaluator.evaluate_cda_file_Etree(evaluator, condition.xpath, file_path)
                evaluation_negative_result = None
                if condition.negative_xpath and condition.negative_xpath != "":
                    evaluation_negative_result = evaluator.evaluate_cda_file_Etree(evaluator, condition.negative_xpath,
                                                                                   file_path)
                values_result = evaluator.evaluate_cda_file_Etree(evaluator, condition.rough_xpath, file_path)

                if len(evaluation_result) > 0:
                    hit = {"hit_result": evaluation_result, "document_id": xml_file.get_document_id(), "document_date": xml_file.get_date_created()}
                    evaluation_results["positive_hits"].append(hit)
                    evaluation_results["evaluation_result_summary"] = "positive_hit"
                if evaluation_negative_result is not None and len(evaluation_negative_result) > 0:
                    hit = {"hit_result": evaluation_negative_result, "document_id": xml_file.get_document_id(), "document_date": xml_file.get_date_created()}
                    evaluation_results["negative_hits"].append(hit)
                    evaluation_results["evaluation_result_summary"] = "negative_hit"
                if len(values_result) > 0:
                    value_result = {"value_result": values_result, "document_id": xml_file.get_document_id(), "document_date": xml_file.get_date_created()}
                    value_results["values"].append(value_result)

            if len(evaluation_results["positive_hits"]) == 0 and len(evaluation_results["negative_hits"]) == 0:
                evaluation_results["evaluation_result_summary"] = "no_hit"
            condition_result["value_results"] = value_results
            condition_result["evaluation_results"] = evaluation_results
            criterion_result["conditions"].append(condition_result)

        tokens = criterion_result["conditions"]
        count_evaluation_summary = Counter(tok['evaluation_results']['evaluation_result_summary'] for tok in tokens)
        if "positive_hit" in count_evaluation_summary:
            criterion_result["criterion_summary_result"] = "positive_hit"
        if "negative_hit" in count_evaluation_summary:
            criterion_result["criterion_summary_result"] = "negative_hit"
        if "positive_hit" in count_evaluation_summary and "negative_hit" in count_evaluation_summary:
            criterion_result["criterion_summary_result"] = "positive_and_negative_hit"
        if "no_hit" in count_evaluation_summary and "positive_hit" not in count_evaluation_summary and "negative_hit" not in count_evaluation_summary:
            criterion_result["criterion_summary_result"] = "no_hit"

        if criterion_result["criterion_summary_result"] == "positive_hit":
            if criterion_result["criterion_type"] == "EK":
                global hit_counter_ek
                hit_counter_ek = hit_counter_ek + 1
            if criterion_result["criterion_type"] == "AK":
                global hit_counter_ak
                hit_counter_ak = hit_counter_ak + 1
        if criterion_result["criterion_summary_result"] == "negative_hit":
            if criterion_result["criterion_type"] == "EK":
                global hit_counter_ek_negative
                hit_counter_ek_negative = hit_counter_ek_negative + 1
            if criterion_result["criterion_type"] == "AK":
                global hit_counter_ak_negative
                hit_counter_ak_negative = hit_counter_ak_negative + 1
        criterion_results.append(criterion_result)

    return criterion_results


def evaluate_information_need(information_need_list, patient):
    information_need_results = []
    for information in information_need_list:
        information_result = {"name": information.name}
        patient_cda_files = model.CDAFile.objects.all().filter(patient_id=patient['patient_id'])

        evaluation_related_cda = None
        values_result = []
        for file in patient_cda_files:
            values_result = evaluator.evaluate_cda_file_Etree(evaluator, information.xpath, file.file)
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
    # TODO: check if cda is already in temp = cache
    gateway = JavaGateway()
    xds_connector = gateway.entry_point
    oid = "1.2.40.0.10.1.4.3.1"
    print("Patient Files get processed from: " + str(patient_id))
    xds_connector.downloadPatientFiles(oid, str(patient_id))
    gateway.close()
    return glob.glob(
        "C:/Users/Raik Müller/Documents/GitHub/RecruitmentTool_Backend/Django_Server/recruitmenttool/cda_files/tempDownload/" + str(
            patient_id) + "/*.xml")


def get_cache_files(patient_id):
    return glob.glob(
        "C:/Users/Raik Müller/Documents/GitHub/RecruitmentTool_Backend/Django_Server/recruitmenttool/cda_files/tempCache/" + str(
            patient_id) + "/*.xml")



