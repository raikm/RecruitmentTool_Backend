import xml.etree.ElementTree as ET
import elementpath
#source: https://eulxml.readthedocs.io/en/latest/xpath.html


class CDAEvaluator:

    def get_root_from_xml(self, cda_file):
        # TODO: valid XML?
        if type(cda_file) != str:
            cda_file.seek(0)
        try:
            tree = ET.parse(cda_file)
        except FileNotFoundError:
            print("Log: CDAEvaluator.get_root_from_xml 'FileNotFoundError'")
            return None

        return tree.getroot()

    def evaluate_cda_file_Etree(self, xpath, cda_file):
        namespaces = {'': 'urn:hl7-org:v3'}
        try:
            root = self.get_root_from_xml(self, cda_file=cda_file)
            results = elementpath.select(root, xpath, namespaces)
        except elementpath.exceptions.ElementPathSyntaxError:
            print("Log: CDAEvaluator.evaluate_cda_file_Etree 'ElementPathSyntaxError'")
            return ["ElementPathSyntaxError"]
        except elementpath.exceptions.ElementPathTypeError:
            print("Log: CDAEvaluator.evaluate_cda_file_Etree 'ElementPathTypeError'")
            return ["ElementPathTypeError"]
        except FileNotFoundError:
            print("Log: CDAEvaluator.evaluate_cda_file_Etree 'FileNotFoundError'")
            return ["FileNotFoundError"]

        if results is not None and len(results) != 0:
            for entry in results:
                # info: that happens if the xpath is not specific enough so no '@' specification at the end
                if type(entry) is ET.Element:
                    index = results.index(entry)
                    results[index] = "Ergebnisse gefunden (siehe ELGA Dokument)"
            return results
        return []



    def evaluate_file_type(self, cda_file):
        if cda_file.content_type == "text/xml":
            return True
        else:
            return False

    #def convertXMLElementResults(self, entry):
    #    xml_str = ET.tostring(entry, encoding='unicode')
    #    print(xml_str)
