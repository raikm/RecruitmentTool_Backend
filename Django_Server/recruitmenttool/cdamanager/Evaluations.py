import api.models as r
from cdamanager.CDAEvaluator import CDAEvaluator as evaluator
import json

class Evaluation:

    def start_evaluation(id, criteria_name, only_current_patient_cohort):

        files = r.CDAFile.objects.all()
        if only_current_patient_cohort is True:
            print("nur aktuelle Kohorte verwenden für Prüfung")
            # files = ueberschreiben

        all_critierums_list = r.Criterium.objects.all().filter(criteria_id=id)
        # response = {}
        criterias = {}

        criterias["criteria_name"] = str(criteria_name)
        criterias['criteriums'] = []
        for c in all_critierums_list:
            criterium = {}
            criterium['criterium_name'] = str(c.name)
            criterium['results'] = []
            for f in files:
                patient_results = {}
                patient_results['patient_ref'] = "DB_ID"
                patient_results['cda_referenz'] = "123"
                result = evaluator.evaluate_cda_file_Etree(evaluator, c.xPath, str(f.file))
                if result is True:
                    patient_results['result'] = 1  # 1 = possible candidate
                else:
                    patient_results['result'] = 0  # 0 = no candidate
                criterium['results'].append(patient_results)

            criterias['criteriums'].append(criterium)

        print(json.dumps(criterias))
