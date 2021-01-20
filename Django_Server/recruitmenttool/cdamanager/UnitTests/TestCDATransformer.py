import configparser
import unittest

import lxml

from Django_Server.recruitmenttool.cdamanager.CDATransformer import CDATransformer


class TestCDATransformer(unittest.TestCase):

    def setUp(self):
        self.cda_transformer = CDATransformer()
        self.cda_test_file = "./Testdata/ELGA-023-Entlassungsbrief_aerztlich_EIS-FullSupport.xml"
        self.cda_invalid_file = "./Testdata/Invalid_CDA_File.xml"
        self.stylesheet_path = "./Testdata/ELGA_Stylesheet_v1.0.xsl"

    def test_transform_xml_to_xsl(self):
        html_dom = self.cda_transformer.transform_xml_to_xsl(cda_filename=self.cda_test_file,
                                                             xsl_filename=self.stylesheet_path)
        self.assertEqual(type(html_dom), lxml.etree._XSLTResultTree)

    def test_transform_xml_to_xsl_no_cda_found(self):
        html_dom = self.cda_transformer.transform_xml_to_xsl(cda_filename="invalid_path",
                                                             xsl_filename=self.stylesheet_path)
        self.assertEqual(html_dom, "Document not found")

    def test_transform_xml_to_xsl_no_valid_cda(self):
        html_dom = self.cda_transformer.transform_xml_to_xsl(cda_filename=self.cda_invalid_file,
                                                             xsl_filename=self.stylesheet_path)
        self.assertEqual(html_dom, "Syntax Error in Document")


if __name__ == '__main__':
    unittest.main()
