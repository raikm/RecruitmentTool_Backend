#import xml.etree.ElementTree as ET
import lxml
import lxml.etree as ET
import os

BASE_DIR = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))

class CDATransformer:

    def transform_xml_to_xsl(self, cda_filename, xsl_filename):
        try:
            dom = ET.parse(cda_filename)
            xslt = ET.parse(BASE_DIR + "/cdamanager/Ressources/ELGA_Referenzstylesheet_1.09.001/ELGA_Stylesheet_v1.0.xsl")
            transform = ET.XSLT(xslt)
            new_dom = transform(dom)
            return new_dom
        except OSError:
            return "Document not found"
        except lxml.etree.XMLSyntaxError:
            return "Syntax Error in Document"

