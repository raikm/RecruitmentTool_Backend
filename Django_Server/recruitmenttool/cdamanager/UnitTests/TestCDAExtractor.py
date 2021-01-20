import unittest
from Django_Server.recruitmenttool.cdamanager.CDAExtractor import CDAExtractor
from datetime import datetime

class TestCDAEvaluator(unittest.TestCase):

    # Testdata
    # File mit Patienten aelter 6 Jahre aber keine weiteren Infos
    cda_test_file = "./Testdata/ELGA-023-Entlassungsbrief_aerztlich_EIS-FullSupport.xml"

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
        result = self.extractor.get_document_id()
        self.assertEqual(str, type(result))
        self.assertEqual("1234567.1", result)

    def test_get_reference_id_from_result(self):
        result = self.extractor.get_reference_id_from_result("""//observation[templateId/@root = "1.2.40.0.34.11.1.3.6"][code/@codeSystem = '2.16.840.1.113883.6.96' and code/@code = '282291009' and starts-with(value/@code, "M25")]/value/@displayName""")
        self.assertEqual(str, type(result[0]))


if __name__ == '__main__':
    unittest.main()