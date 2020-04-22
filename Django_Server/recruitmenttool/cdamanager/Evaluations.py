import api.models as model
from .CDAEvaluator import CDAEvaluator as evaluator
import json
from .CDAExtractor import CDAExtractor

# TODO: remove class concept
class Evaluation:

    def old_start_evaluation(id, criteria_name, only_current_patient_cohort):
        files = model.CDAFile.objects.all()
        if only_current_patient_cohort is True:
            print("nur aktuelle Kohorte verwenden für Prüfung")
            # files = ueberschreiben

        all_critierums_list = model.Criterium.objects.all().filter(criteria_id=id)
        criterias = {}
        criterias["criteria_name"] = str(criteria_name)
        criterias['criteriums'] = []
        for c in all_critierums_list:
            criterium = {}
            criterium['criterium_name'] = str(c.name)
            criterium['results'] = []
            for f in files:
                patient_results = {}
                patient_results['patient_ref_id'] = f.patient_id
                patient_results['cda_db_id'] = f.id
                result = evaluator.evaluate_cda_file_Etree(
                    evaluator, c.xPath, str(f.file))
                if result is True:
                    patient_results['result_code'] = 1
                    patient_results['result_code_text'] = "match"  # 1 = match
                else:
                    patient_results['result_code'] = 0
                    patient_results['result_code_text'] = "no match"  # 0 = no match
                criterium['results'].append(patient_results)

            criterias['criteriums'].append(criterium)

        print(json.dumps(criterias))

    def start_evaluation(id):
        #TODO refactor names of dic and so on
        critierum_list = model.Criterium.objects.all().filter(criteria_id=id)
        patient_list = model.Patient.objects.all()

        patients_dic = {}
        patients_dic["patients"] = []
        for patient in patient_list:
            patient_dict = {}
            patient_dict["patient_id"] = patient.patient_id
            patient_dict["patient_first_name"] = patient.first_name
            patient_dict["patient_middle_names"] = patient.middle_names
            patient_dict["patient_last_name"] = patient.last_name
            patient_dict["birthTime"] = str(patient.birthdate) # TODO CONVERT TO JSON FORMAT!
            patient_dict["results"] = []
            patient_db_id = patient.id
            patient_cda_files = patient_list = model.CDAFile.objects.all().filter(patient_id = patient_db_id)
            for criterium in critierum_list:
                result = {}
                result["criterum_id"] = criterium.id
                result["criterum_name"] = criterium.name
                evaluation_result = False
                evaluation_result_text = "no match"
                evaluation_related_cda = None
                for file in patient_cda_files:
                    print("check: " + str(file) + " criterium: " + criterium.name + ":   " + criterium.xPath)
                    evaluation_result = evaluator.evaluate_cda_file_Etree(evaluator, criterium.xPath, file.file)
                    if evaluation_result is not True:
                        continue
                    evaluation_result_text = "match"
                    evaluation_related_cda = file.cda_id
                    break

                result["evaluation_result"] = evaluation_result
                result["evaluation_result_text"] = evaluation_result_text
                result["evaluation_related_cda"] = evaluation_related_cda
                patient_dict["results"].append(result)

            patients_dic["patients"].append(patient_dict)
        print(json.dumps(patients_dic))
        return json.dumps(patients_dic)
