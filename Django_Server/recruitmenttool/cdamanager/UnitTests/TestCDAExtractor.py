import unittest
from CDAExtractor import CDAExtractor
from datetime import datetime

class TestCDAEvaluator(unittest.TestCase):

    # Testdata
    cda_test_file = "/Volumes/Macintosh HDD/Benutzer/RaikMueller/PyCharmProjects/RecruitmentTool_Backend/resources/ELGA-023-Entlassungsbrief_aerztlich_EIS-FullSupport.xml"
    # File mit Patienten aelter 6 Jahre aber keine weiteren Infos
    cda_simple_file = "/Volumes/Macintosh HDD/Benutzer/RaikMueller/PyCharmProjects/RecruitmentTool_Backend/resources/simple_birthday.xml"
    global extractor

    def setUp(self):
        self.extractor = CDAExtractor(self.cda_test_file)

    def test_get_patient_name(self):
        result = self.extractor.get_patient_name()
        self.assertEqual("Herbert",result['vornamen'][0])
        self.assertEqual("Hannes", result['vornamen'][1])
        self.assertEqual("Mustermann", result['nachname'][0])

    def test_get_birhtTime(self):
        result = self.extractor.get_birthTime()
        self.assertEqual(datetime, type(result))
        date = datetime(1961, 12, 24)
        self.assertEqual(date, result)

    def test_get_patient_id(self):
        result = self.extractor.get_patient_id()
        self.assertEqual(1111241261, result)

    def test_get_date_created(self):
        result = self.extractor.get_date_created()
        self.assertEqual(datetime, type(result))
        date = datetime.strptime("20160817121500+0100", '%Y%m%d%H%M%S%z')
        self.assertEqual(date, result)

    def test_get_cda_id(self):
        result = self.extractor.get_cda_id()
        #self.assertEqual(1, len(result))
        #self.assertEqual("1234567.1", result[0])

    def test_get_xPath_value(self):
        cda_entlassungsbrief_aerztlich = "UnitTests/Testdata/ELGA-023-Entlassungsbrief_aerztlich_EIS-FullSupport.xml"
        xPath_diagnose_m25 = """//observation[templateId/@root = "1.2.40.0.34.11.1.3.6" and templateId/@root = "1.3.6.1.4.1.19376.1.5.3.1.4.5" and templateId/@root = "2.16.840.1.113883.10.20.1.28"]/*[(self::effectiveTime) | (self::value/@code)]"""
        self.extractor.get_xPath_value(xPath_diagnose_m25, cda_entlassungsbrief_aerztlich)

if __name__ == '__main__':
    unittest.main()
