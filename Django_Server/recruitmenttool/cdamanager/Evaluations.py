import api.models as model
from .CDAEvaluator import CDAEvaluator as evaluator
import json


def evaluate_request(id):
    critierum_list = model.Criterium.objects.all().filter(criteria_id=id)
    patient_list = model.Patient.objects.all()
    patients_dic = {}
    patients_dic["patients"] = []
    for p in patient_list:
        patient = {}
        patient["patient_id"] = p.patient_id
        patient["patient_first_name"] = p.first_name
        patient["patient_middle_names"] = p.middle_names
        patient["patient_last_name"] = p.last_name
        patient["birthTime"] = str(p.birthdate) #TODO: convert to JSON Format
        patient["results"] = []
        patient_db_id = p.id
        patient_cda_files = patient_list = model.CDAFile.objects.all().filter(patient_id = patient_db_id)
        for criterium in critierum_list:
            result = {}
            result["criterum_id"] = criterium.id
            result["criterum_name"] = criterium.name
            evaluation_result = False
            evaluation_result_text = "no match"
            evaluation_related_cda = None
            for file in patient_cda_files:
                evaluation_result = evaluator.evaluate_cda_file_Etree(evaluator, criterium.xPath, file.file)
                if evaluation_result is not True:
                    continue
                evaluation_result_text = "match"
                evaluation_related_cda = file.cda_id
                break

            result["evaluation_result"] = evaluation_result
            result["evaluation_result_text"] = evaluation_result_text
            result["evaluation_related_cda"] = evaluation_related_cda
            patient["results"].append(result)

        patients_dic["patients"].append(patient)
    return json.dumps(patients_dic)
