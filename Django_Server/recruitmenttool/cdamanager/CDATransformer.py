#import xml.etree.ElementTree as ET
import lxml
import lxml.etree as ET

class CDATransformer:

    def transform_xml_to_xsl(self, cda_filename, xsl_filename):
        try:
            dom = ET.parse(cda_filename)
            xslt = ET.parse(xsl_filename)
            transform = ET.XSLT(xslt)
            new_dom = transform(dom)
            return new_dom
        except OSError:
            return "Document not found"
        except lxml.etree.XMLSyntaxError:
            return "Syntax Error in Document"

