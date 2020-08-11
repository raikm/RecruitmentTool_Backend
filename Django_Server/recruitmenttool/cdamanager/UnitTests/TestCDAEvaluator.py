import unittest
from cdamanager.CDAEvaluator import CDAEvaluator as evaluator


class TestCDAEvaluator(unittest.TestCase):

    ### Testdata ###
    xPath_a_g_6 = """//recordTarget[number(substring(patientRole/patient/birthTime/@value,1,4)) < 2015]/patientRole/patient/birthTime/@value"""
    xPath_diagnose_m25 = """//observation[templateId/@root = "1.2.40.0.34.11.1.3.6"][code/@codeSystem = '2.16.840.1.113883.6.96' and code/@code = '282291009' and starts-with(value/@code, "M25.46")]/value/@displayName"""
    xPath_diagnosen_value = """//observation[templateId/@root = "1.2.40.0.34.11.1.3.6"][code/@codeSystem = '2.16.840.1.113883.6.96' and code/@code = '282291009']/value/@displayName"""
    xPath_ns = """//observation[templateId/@root = "1.2.40.0.34.11.1.3.6"][code/@codeSystem = '2.16.840.1.113883.6.96' and code/@code = '282291009' and starts-with(value/@code, "H6")]/value/@displayName"""
    xPath_nd = """//observation[templateId/@root = "1.2.99.0.34.11.1.3.6" and templateId/@root = "1.3.6.1.4.1.19376.1.5.3.1.4.5" and templateId/@root = "2.16.840.1.113883.10.20.1.28" and value/@code = "M22.46"]"""
    #TODO: xPaths mit mehr templateIDs fuer robustheit
    xPath_a_g_200 = """//recordTarget[number(substring(patientRole/patient/birthTime/@value,1,4)) < 1820]/patientRole/patient/birthTime/@value"""
    xPath_no_valide = """$$$$$$/z/ordTarget[number(substring(patientRole/patient/birthTime/@value,1,4)) < 1820]/patientRole/patient/birthTime/@value"""
    # File mit Patienten aelter 6 Jahre
    cda_entlassungsbrief_aerztlich = "./Testdata/ELGA-023-Entlassungsbrief_aerztlich_EIS-FullSupport.xml"
    cda_pflegebericht = "./Testdata/modified_patient_example_data/CDA_Pflegebericht_von_Robert_Koch.xml"
    cda_laborbefund = "./Testdata/modified_patient_example_data/CDA_Laborbefund_von_Klaus.xml"

    no_valide_file = "no_valid_path"

    SATISFIED = "SATISFIED"
    NOT_SATISFIED = "NOT_SATISFIED"
    NO_DATA = "NO_DATA"
    ERROR = "ERROR"

    def test_evaluate_cda_file_satisfied(self):
        result_xPath_Condition = evaluator.evaluate_cda_file_Etree(
        evaluator, self.xPath_diagnose_m25, self.cda_entlassungsbrief_aerztlich)
        self.assertEqual(1, len(result_xPath_Condition))
        result_xPath_Values = evaluator.evaluate_cda_file_Etree(
            evaluator, self.xPath_diagnosen_value, self.cda_entlassungsbrief_aerztlich)
        self.assertEqual(2, len(result_xPath_Values))

    def test_evaluate_cda_file_no_data(self):
        result_xPath_Condition = evaluator.evaluate_cda_file_Etree(
        evaluator, self.xPath_ns, self.cda_entlassungsbrief_aerztlich)
        self.assertEqual(self.NO_DATA, result_xPath_Condition)

    def test_evaluate_laboratory_report(self):
        result = evaluator.evaluate_cda_file_Etree(
        evaluator, self.xPath_a_g_6, self.cda_laborbefund)
        self.assertEqual(['19611224'], result)

    def test_evaluate_nursing_report(self):
        result = evaluator.evaluate_cda_file_Etree(
        evaluator, self.xPath_a_g_6, self.cda_pflegebericht)
        self.assertEqual(self.NO_DATA, result) # birthtime UNK

    def test_evaluate_cda_file_Wrong_xPath(self):
        result = evaluator.evaluate_cda_file_Etree(evaluator, self.xPath_no_valide, self.cda_entlassungsbrief_aerztlich)
        self.assertEqual(self.ERROR, result)

    def test_evaluate_cda_file_no_valide_file(self):
        result = evaluator.evaluate_cda_file_Etree(evaluator, self.xPath_a_g_6, self.no_valide_file)
        self.assertEqual(self.ERROR, result)

if __name__ == '__main__':
    unittest.main()
