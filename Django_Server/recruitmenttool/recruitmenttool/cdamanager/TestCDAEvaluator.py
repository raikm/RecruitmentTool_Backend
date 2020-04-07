import unittest
from CDAEvaluator import CDAEvaluator as evaluator

class TestCDAEvaluator(unittest.TestCase):

    #Testdata
    xPath_a_g_6 = """//recordTarget[number(substring(patientRole/patient/birthTime/@value,1,4)) < 2015]/patientRole/patient/birthTime/@value"""
    xPath_age = """//recordTarget[number(substring(patientRole/patient/birthTime/@value)]"""
    xPath_a_g_100 = """//recordTarget[number(substring(patientRole/patient/birthTime/@value,1,4)) < 1920]/patientRole/patient/birthTime/@value"""
    cda_test_file = "/Volumes/Macintosh HDD/Benutzer/RaikMueller/PyCharmProjects/RecruitmentTool_Backend/resources/ELGA-023-Entlassungsbrief_aerztlich_EIS-FullSupport.xml"
        #File mit Patienten aelter 6 Jahre
    cda_simple_file = "/Volumes/Macintosh HDD/Benutzer/RaikMueller/PyCharmProjects/RecruitmentTool_Backend/resources/simple_birthday.xml"

    def test_evaluate_cda_file_Etree_True(self):
        result = evaluator.evaluate_cda_file_Etree(evaluator, self.xPath_a_g_6, self.cda_test_file)
        print(result)
        self.assertTrue(result)

    def test_evaluate_cda_file_Etree_False(self):
        #result = evaluator.evaluate_cda_file_Etree(evaluator, self.xPath_a_g_6, self.cda_test_file)
        #print(result)
        #self.assertFalse(result)
        pass

    def test_evaluate_cda_file_True(self):
        result = evaluator.evaluate_cda_file(evaluator, self.xPath_a_g_6, self.cda_test_file)
        print(result)
        self.assertTrue(result)

    def test_evaluate_cda_file_False(self):
        #result = evaluator.evaluate_cda_file(evaluator, self.xPath_a_g_100, self.cda_simple_file)
        #print(result)
        #self.assertFalse(result)
        pass



if __name__ == '__main__':
    unittest.main()