import xml.etree.ElementTree as ET
import elementpath
from datetime import datetime
import sys
# sys.path.append("/Volumes/Macintosh HDD/Benutzer/RaikMueller/libsaxon-EEC-mac-setup-v1.2.1/Saxon.C.API/python-saxon")
# from saxonc import *
# import saxonc
import pytz

class CDAExtractor:

# Do note that one must avoid the // abbreviation whenever possible as it causes the whole document (subtree rooted at the context node) to be scanned.
    ERROR = "ERROR"

    def __init__(self, cda_file):
        self.cda_file = cda_file
        self.tree = ET.parse(self.cda_file)
        self.root = self.tree.getroot()
        # find namespace out programmatcily if needed
        self.namespaces = {'': 'urn:hl7-org:v3',
                      'xmlns:xsi': 'http://www.w3.org/2001/XMLSchema-instance'}

    def get_namespace(self):
        pass

    def get_patient_name(self):
        xPathVornamen = """//recordTarget/patientRole/patient/name/given/text()"""
        xPathNachname = """//recordTarget/patientRole/patient/name/family[not(@qualifier)]/text()"""
        result = {}
        result['vornamen'] = elementpath.select(self.root, xPathVornamen, self.namespaces)
        result['nachname'] = elementpath.select(self.root, xPathNachname, self.namespaces)
        return result

    def get_birthTime(self):
        xPath = """//recordTarget/patientRole/patient/birthTime/@value"""
        resultStr = elementpath.select(self.root, xPath, self.namespaces)
        result = datetime.strptime(resultStr[0], '%Y%m%d')
        return result

    def get_patient_id(self):
        xPath = """//recordTarget/patientRole/id[@root="1.2.40.0.10.1.4.3.1"]/@extension"""
        result = elementpath.select(self.root, xPath, self.namespaces)
        return int(result[0])

    def get_document_id(self):
        xPath = """/*/id[@root="1.2.40.0.34.99.4613.3.1"]/@extension"""
        result = elementpath.select(self.root, xPath, self.namespaces)
        #TODO: define all possible Document ID xPaths
        if len(result) == 0:
            xPath = """/*/id[@root="1.2.40.0.10.1.4.3.4.2.1"]/@extension"""
            result = elementpath.select(self.root, xPath, self.namespaces)
        return result[0]

    def get_date_created(self):
        xPath = """/ClinicalDocument/effectiveTime/@value"""
        resultStr = elementpath.select(self.root, xPath, self.namespaces)
        result = None
        #print(resultStr[0])
        #TODO: falsches Datum abfangen
        if len(resultStr[0]) == 19:
            result = datetime.strptime(resultStr[0], '%Y%m%d%H%M%S%z')
        if len(resultStr[0]) == 8:
            result = datetime.strptime(resultStr[0], '%Y%m%d')
            result = pytz.utc.localize(result)
        return result

    def get_CDA_type(self):
        pass


    def get_root_from_xml(self, cda_file):
        # TODO: valid XML?
        if type(cda_file) != str:
            cda_file.seek(0)
        try:
            tree = ET.parse(cda_file)
        except FileNotFoundError:
            print("FILE NOT FOUND")  # TODO: better error handling

        return tree.getroot()
