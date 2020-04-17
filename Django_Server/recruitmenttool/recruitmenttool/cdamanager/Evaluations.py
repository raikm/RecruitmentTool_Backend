import recruitmenttool.models as r
from recruitmenttool.cdamanager.CDAEvaluator import CDAEvaluator as evaluator


class Evaluation:

    def start_evaluation(id, only_current_patient_cohort):

        files = r.CDAFile.objects.all()
        if only_current_patient_cohort is True:
            print("nur aktuelle Kohorte verwenden für Prüfung")
            # files = ueberschreiben

        criterias = r.Criterium.objects.all().filter(criteria_id=id)
        for c in criterias:
            print(c.xPath)
            for f in files:
                print(f.file)
                result = evaluator.evaluate_cda_file_Etree(
                    evaluator, c.xPath, str(f.file))
                print(result)
