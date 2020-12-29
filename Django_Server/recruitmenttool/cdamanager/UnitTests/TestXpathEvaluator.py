import unittest
from Django_Server.recruitmenttool.cdamanager.XpathEvaluator import XpathEvaluator


class TestXpathEvaluator(unittest.TestCase):

    def setUp(self):
        self.xpath_valid = """//observation[templateId/@root="1.2.40.0.34.11.1.3.6"][code/@codeSystem='2.16.840.1.113883.6.96'andcode/@code='282291009'andstarts-with(value/@code,"M25.46")]/value/@displayName"""
        self.xpath_no_valid = """//[templateId/@root="1.2.40.0.34.11.1.3.6"][code/@codeSystem='2.16.840.1.113883.6.96'andcode/@code='282291009'andstarts-with(value/@code,"M25.46")]/value/@displayName"""
        self.xpath_valid_with_space = """//observation[templateId/@root = "1.2.40.0.34.11.1.3.6"][code/@codeSystem = '2.16.840.1.113883.6.96'andcode/@code='282291009'andstarts-with(value/@code,"M25.46")]/value/@displayName"""
        self.xpath_valid_with_space_at_end = """//observation[templateId/@root = "1.2.40.0.34.11.1.3.6"][code/@codeSystem = '2.16.840.1.113883.6.96'andcode/@code='282291009'andstarts-with(value/@code,"M25.46")]/value/@displayName               """
    def test_validate_xpath__with_valide_xpath(self):
        result = XpathEvaluator.validate_xpath(XpathEvaluator, xpath=self.xpath_valid)
        self.assertEqual("""//observation[templateId/@root="1.2.40.0.34.11.1.3.6"][code/@codeSystem='2.16.840.1.113883.6.96'andcode/@code='282291009'andstarts-with(value/@code,"M25.46")]/value/@displayName""", result)


    def test_validate_xpath__with_no_valide_xpath(self):
        result = XpathEvaluator.validate_xpath(XpathEvaluator, xpath=self.xpath_no_valid)
        self.assertEqual("", result)


    def test_remove_blankspaces(self):
        result = XpathEvaluator.validate_xpath(XpathEvaluator, xpath=self.xpath_valid_with_space)
        self.assertEqual("""//observation[templateId/@root="1.2.40.0.34.11.1.3.6"][code/@codeSystem='2.16.840.1.113883.6.96'andcode/@code='282291009'andstarts-with(value/@code,"M25.46")]/value/@displayName""", result)

    def test_remove_ten_blankspaces(self):
        result = XpathEvaluator.validate_xpath(XpathEvaluator, xpath=self.xpath_valid_with_space_at_end)
        self.assertEqual(
            """//observation[templateId/@root="1.2.40.0.34.11.1.3.6"][code/@codeSystem='2.16.840.1.113883.6.96'andcode/@code='282291009'andstarts-with(value/@code,"M25.46")]/value/@displayName""",
            result)


    if __name__ == '__main__':
        unittest.main()
