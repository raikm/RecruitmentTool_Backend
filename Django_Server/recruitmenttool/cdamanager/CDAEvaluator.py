# import sys
# sys.path.append("/Volumes/Macintosh HDD/Benutzer/RaikMueller/libsaxon-EEC-mac-setup-v1.2.1/Saxon.C.API/python-saxon")
# from saxonc import *
# import saxonc
import xml.etree.ElementTree as ET
import elementpath
import os


class CDAEvaluator:

    # SAXCON Library
    # proc = saxonc.PySaxonProcessor(license=True)

    # def evaluate_cda_file(self, xPath, cda_file_path):
    #     try:
    #         xp = self.proc.new_xpath_processor()
    #         xp.declare_namespace("xmlns:xsi", "http://www.w3.org/2001/XMLSchema-instance")
    #         xp.declare_namespace("", "urn:hl7-org:v3")
    #         xp.set_context(file_name=cda_file_path)
    #         print("-------------------------------")
    #         print(cda_file_path)
    #         print(xPath)
    #         print("start evaluate")
    #         print("-------------------------------")
    #         results = xp.evaluate(xPath)
    #
    #         xp.clear_parameters()
    #         xp.clear_properties()
    #     except:
    #         print("---------------ERROR----------------")
    #     if results is None:
    #         del results
    #         return False
    #     del results
    #     return True
    #
    # def clean_up(self):
    #     self.proc.clear_configuration_properties()
    #     self.proc.release()

    def evaluate_cda_file_Etree(self, xPath, cda_file):
        if type(cda_file) != str:
            cda_file.seek(0)
        try:
            tree = ET.parse(cda_file)
        except FileNotFoundError:
            return False
        #TODO: valid XML?
        root = tree.getroot()
        # TODO: read header for namespace
        namespaces = {'': 'urn:hl7-org:v3',
                      'xmlns:xsi': 'http://www.w3.org/2001/XMLSchema-instance'}
        try:
            results = elementpath.select(root, xPath, namespaces)
        except elementpath.exceptions.ElementPathSyntaxError:
            results = None

        if results is None or len(results) == 0:
            return False
        return True


    
