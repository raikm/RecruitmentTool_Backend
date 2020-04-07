import sys
sys.path.append("/Volumes/Macintosh HDD/Benutzer/RaikMueller/libsaxon-EEC-mac-setup-v1.2.1/Saxon.C.API/python-saxon")
from saxonc import *
import saxonc
import xml.etree.ElementTree as ET
import elementpath


class CDAEvaluator:

    # SAXCON Library
    def evaluate_cda_file(self, xPath, cda_file_path):#TODO später: GET NAMESPACE DATA
        with saxonc.PySaxonProcessor(license=True) as proc:
            print("START SAXCON EVALUATION")
            print("xPath: " + xPath)
            print("Cda File Path: " + cda_file_path)
            xp = proc.new_xpath_processor()

            #'' : 'urn:hl7-org:v3',
            #'xmlns:xsi': 'http://www.w3.org/2001/XMLSchema-instance'}
            xp.declare_namespace("xmlns:xsi", "http://www.w3.org/2001/XMLSchema-instance")
            xp.declare_namespace("", "urn:hl7-org:v3")

            xp.set_context(file_name=cda_file_path)
            results = xp.evaluate(xPath)
            print(results)
            print(type(results))
            if results is None:
                return False
            return True


    def evaluate_cda_file_Etree(self, xPath, cda_file_path):
        print("START EVALUATION")
        print("xPath: " + xPath)
        print("Cda File Path: " + cda_file_path)

        tree = ET.parse(cda_file_path)
        root = tree.getroot()


        namespaces = {          '' : 'urn:hl7-org:v3',
                        'xmlns:xsi': 'http://www.w3.org/2001/XMLSchema-instance'}

        results = elementpath.select(root, xPath, namespaces)
        print(results)
        print(type(results))
        if results is None:
            return False
        return True