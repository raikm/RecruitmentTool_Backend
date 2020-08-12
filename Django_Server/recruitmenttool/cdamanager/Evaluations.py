import api.models as model
from .CDAEvaluator import CDAEvaluator as evaluator
from .CDAExtractor import CDAExtractor as extractor
import json
import api.serializers as serializer

SATISFIED = "SATISFIED"
NOT_SATISFIED = "NOT_SATISFIED"
NO_DATA = "NO_DATA"
ERROR = "ERROR"


def evaluate_request(id):
    critierum_list = model.Criterium.objects.all().filter(study_id=id)
    information_need_list = model.Information_Need.objects.all().filter(study_id=id)
    patient_list = model.Patient.objects.all()
    if len(patient_list) == 0: raise Exception("No Patients in DB found")
    patients_dic = {}
    patients_dic["patients"] = []

    for patient in patient_list:
        patient_result = get_patient(patient)
        patient_result["criterium_results"] = evaluate_criterions(critierum_list, patient)
        patient_result["information_needed_results"] = evaluate_information_need(information_need_list, patient)
        patients_dic["patients"].append(patient_result)

    return json.dumps(patients_dic)



def get_patient(patient):
    return serializer.PatientSerializer(patient).data

def get_condtion(condition):
    return serializer.ConditionSerializer(condition).data

def evaluate_criterions(critierum_list, patient):
    criterium_results = []
    for criterium in critierum_list:
        criterium_result = {}
        criterium_result["name"] = criterium.name
        criterium_result["criterium_type"] = criterium.criterium_type
        criterium_result["conditions"] = []

        conditions = model.Condition.objects.all().filter(criterium_id =  criterium.id)
        print(conditions)
        for condition in conditions:
            condition_result = {}
            condition_result["name"] = condition.name

            evaluation_result = []
            evaluation_results = []
            values_result = []
            evaluation_related_cda = None

            patient_cda_files = model.CDAFile.objects.all().filter(patient_id =  patient.id)


            #TODO: order patient_cda_files by date

            for file in patient_cda_files:
                evaluation_result = evaluator.evaluate_cda_file_Etree(evaluator, condition.xPath, file.file)
                values_result = evaluator.evaluate_cda_file_Etree(evaluator, condition.value_xPath, file.file)
                #TODO: negative_evaluation_result
                if evaluation_result is NO_DATA:
                    continue
                if evaluation_result is ERROR:
                    continue
                if len(evaluation_result) == 0:
                    continue
                #TODO: resturn ALL founds results with linked cda's
                if len(evaluation_result) > 0:
                    evaluation_results.append(evaluation_result)
                    evaluation_related_cda = file.cda_id
                    continue

            condition_result["evaluation_result"] = evaluation_results
            condition_result["evaluation_related_cda"] = evaluation_related_cda
            condition_result["values_result"] = values_result
            criterium_result["conditions"].append(condition_result)

        #TODO: change if negative xPaths are implemented
        criterium_result["criterium_summary_result"] = 0 if len(condition_result["evaluation_result"]) > 0 else 1
        criterium_results.append(criterium_result)

    return criterium_results


def evaluate_information_need(information_need_list, patient):
    information_need_results = []
    for information in information_need_list:
        information_result = {}
        information_result["name"] = information.name
        patient_cda_files = model.CDAFile.objects.all().filter(patient_id =  patient.id)

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
