import unittest
from CDAEvaluator import CDAEvaluator as evaluator


class TestCDAEvaluator(unittest.TestCase):

    # Testdata
    xPath_a_g_6 = """//recordTarget[number(substring(patientRole/patient/birthTime/@value,1,4)) < 2015]/patientRole/patient/birthTime/@value"""
    xPath_age = """//recordTarget[number(substring(patientRole/patient/birthTime/@value)]"""
    xPath_a_g_200 = """//recordTarget[number(substring(patientRole/patient/birthTime/@value,1,4)) < 1820]/patientRole/patient/birthTime/@value"""
    xPath_no_valide = """$$$$$$/z/ordTarget[number(substring(patientRole/patient/birthTime/@value,1,4)) < 1820]/patientRole/patient/birthTime/@value"""
    cda_test_file = "/Volumes/Macintosh HDD/Benutzer/RaikMueller/PyCharmProjects/RecruitmentTool_Backend/resources/ELGA-023-Entlassungsbrief_aerztlich_EIS-FullSupport.xml"
    # File mit Patienten aelter 6 Jahre
    cda_simple_file = "/Volumes/Macintosh HDD/Benutzer/RaikMueller/PyCharmProjects/RecruitmentTool_Backend/resources/simple_birthday.xml"
    no_valide_file = "/VoluMacintosh HDD/Benutzer/RaikMueller/PyCharmProjects/RecruitmentTool_Backend/resources/simple_birthday.xml"

    def test_evaluate_cda_file_True(self):
        result = evaluator.evaluate_cda_file_Etree(
            evaluator, self.xPath_a_g_6, self.cda_test_file)
        self.assertTrue(result)

    def test_evaluate_cda_file_False(self):
        result = evaluator.evaluate_cda_file_Etree(
            evaluator, self.xPath_a_g_200, self.cda_test_file)
        self.assertFalse(result)

    def test_evaluate_cda_file_Wrong_xPath(self):
        result = evaluator.evaluate_cda_file_Etree(evaluator, self.xPath_no_valide, self.cda_test_file)
        self.assertFalse(result)

    def test_evaluate_cda_file_no_valide_file(self):
        result = evaluator.evaluate_cda_file_Etree(evaluator, self.xPath_a_g_6, self.no_valide_file)
        self.assertFalse(result)


if __name__ == '__main__':
    unittest.main()
