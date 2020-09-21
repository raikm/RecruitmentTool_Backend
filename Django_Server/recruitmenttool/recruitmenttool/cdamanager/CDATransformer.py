#import xml.etree.ElementTree as ET
import lxml.etree as ET

class CDATransformer:

    def transform_xml_to_xsl(self, cda_filename, xsl_filename):
        dom = ET.parse(cda_filename)
        xslt = ET.parse(xsl_filename)
        transform = ET.XSLT(xslt)
        newdom = transform(dom)
        return newdom
