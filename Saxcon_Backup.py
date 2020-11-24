#import sys
#sys.path.append("/Volumes/Macintosh HDD/Benutzer/RaikMueller/libsaxon-EEC-mac-setup-v1.2.1/Saxon.C.API/python-saxon")
#from saxonc import *
#import saxonc
    # SAXCON Library
    #proc = saxonc.PySaxonProcessor(license=True)

    # def evaluate_cda_file(self, xpath, cda_file_path):
    #     try:
    #         xp = self.proc.new_xpath_processor()
    #         xp.declare_namespace("xmlns:xsi", "http://www.w3.org/2001/XMLSchema-instance")
    #         xp.declare_namespace("", "urn:hl7-org:v3")
    #         xp.set_context(file_name=cda_file_path)
    #         print("-------------------------------")
    #         print(cda_file_path)
    #         print(xpath)
    #         print("start evaluate")
    #         print("-------------------------------")
    #         results = xp.evaluate(xpath)
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
