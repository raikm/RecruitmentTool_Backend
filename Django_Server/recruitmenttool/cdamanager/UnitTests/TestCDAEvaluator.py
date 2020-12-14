import unittest
import xml

from Django_Server.recruitmenttool.cdamanager.CDAEvaluator import CDAEvaluator as evaluator


class TestCDAEvaluator(unittest.TestCase):

    xPath_diagnose_m25 = """//observation[templateId/@root = "1.2.40.0.34.11.1.3.6"][code/@codeSystem = '2.16.840.1.113883.6.96' and code/@code = '282291009' and starts-with(value/@code, "M25.46")]/value/@displayName"""
    xPath_diagnose_with_out_value = """//observation[templateId/@root = "1.2.40.0.34.11.1.3.6"][code/@codeSystem = '2.16.840.1.113883.6.96' and code/@code = '282291009' and starts-with(value/@code, "M25.46")]/value"""
    xPath_diagnosen_value = """//observation[templateId/@root = "1.2.40.0.34.11.1.3.6"][code/@codeSystem = '2.16.840.1.113883.6.96' and code/@code = '282291009']/value/@displayName"""
    xPath_a_g_200 = """//recordTarget[number(substring(patientRole/patient/birthTime/@value,1,4)) < 1820]/patientRole/patient/birthTime/@value"""
    xPath_no_valide = """$$$$$$/z/ordTarget[number(substring(patientRole/patient/birthTime/@value,1,4)) < 1820]/patientRole/patient/birthTime/@value"""
    # File mit Patienten aelter 6 Jahre
    cda_entlassungsbrief_aerztlich = "./Testdata/ELGA-023-Entlassungsbrief_aerztlich_EIS-FullSupport.xml"
    no_xml_file = "../CDAEValuator.py"

    no_valide_file = "no_valid_path"



    def test_get_root_from_xml_with_valid_cda_file(self):
        result = evaluator.get_root_from_xml(evaluator,self.cda_entlassungsbrief_aerztlich)
        self.assertEqual(xml.etree.ElementTree.Element, type(result), "Result is not a type of Element")

    def test_evaluate_cda_file_Etree_value_hit(self):
        result = evaluator.evaluate_cda_file_Etree(evaluator, self.xPath_diagnose_m25,
                                                   self.cda_entlassungsbrief_aerztlich)
        self.assertEqual(1, len(result), "Result length should be 1")
        self.assertEqual("Gelenkerguss: Unterschenkel", result[0], "Not excpected hit!")

    def test_evaluate_cda_file_Etree_xml_hit(self):
        result = evaluator.evaluate_cda_file_Etree(evaluator, self.xPath_diagnose_with_out_value,
                                                   self.cda_entlassungsbrief_aerztlich)
        self.assertEqual(1, len(result), "Result length should be 1")
        self.assertEqual(str, type(result[0]), "Result should be a String!")
        self.assertEqual("Ergebnisse gefunden (siehe ELGA Dokument)", result[0], "Result should be a String Info!")

    def test_evaluate_cda_file_Etree_no_hit(self):
        result = evaluator.evaluate_cda_file_Etree(evaluator, self.xPath_a_g_200,
                                                   self.cda_entlassungsbrief_aerztlich)
        self.assertEqual(0, len(result), "Result length should be 0")

    def test_evaluate_cda_file_Etee_no_valid_file(self):
        result = evaluator.get_root_from_xml(evaluator, self.no_valide_file)
        self.assertEqual(None, result)
        result = evaluator.evaluate_cda_file_Etree(evaluator, self.xPath_diagnose_m25,
                                                   self.no_valide_file)
        self.assertEqual("ElementPathTypeError", result[0])

    def test_evaluate_cda_file_Etee_no_valid_xpath_syntax(self):
        result = evaluator.evaluate_cda_file_Etree(evaluator, self.xPath_no_valide,
                                                   self.cda_entlassungsbrief_aerztlich)
        self.assertEqual(1, len(result), "Result length should be 1")
        self.assertEqual("ElementPathSyntaxError", result[0], "Result should be an exception")

if __name__ == '__main__':
    unittest.main()
