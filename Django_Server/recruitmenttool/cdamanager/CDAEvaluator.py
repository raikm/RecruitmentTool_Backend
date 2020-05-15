#import sys
#sys.path.append("/Volumes/Macintosh HDD/Benutzer/RaikMueller/libsaxon-EEC-mac-setup-v1.2.1/Saxon.C.API/python-saxon")
#from saxonc import *
#import saxonc
import xml.etree.ElementTree as ET
import elementpath

import eulxml.xpath

class CDAEvaluator:
    SATISFIED = "SATISFIED"
    NOT_SATISFIED = "NOT_SATISFIED"
    NO_DATA = "NO_DATA"
    ERROR = "ERROR"

    def get_properties_from_ast(n):
        OPERATOR_MAPPING = {'and', 'not', 'or'}
        COMPARISON_MAPPING = {'>', '>=', '<', '<=', "=", "!="}

        dictionary = dict()

        nodeList = n.relative.predicates
        print(nodeList)
        templateList = []
        for node in nodeList:

            def visit(node):
                if type(node.right) is not str and node.right.op in list(COMPARISON_MAPPING):
                    if "templateId" in str(node.right):
                        templateList.append(eulxml.xpath.serialize(node.right))

            visit(node)
            while node.left.op in list(OPERATOR_MAPPING):
                node = node.left
                visit(node)
            if node.left.op in list(COMPARISON_MAPPING):
                if "templateId" in str(node):
                    templateList.append(eulxml.xpath.serialize(node.left))

        dictionary["templatedId"] = templateList

        return dictionary

    def get_properties_from_xpath(self, xpath):
        return self.get_properties_from_ast(eulxml.xpath.parse(xpath))

    def evaluate_cda_file_Etree(self, xPath, cda_file):
        if type(cda_file) != str:
            cda_file.seek(0)
        try:
            tree = ET.parse(cda_file)
        except FileNotFoundError:
            return self.ERROR
        #TODO: valid XML?
        root = tree.getroot()
        # TODO: read header for namespace
        #elementpath.XPath2Parser().namespaces
        namespaces = {'': 'urn:hl7-org:v3',
                      'xmlns:xsi': 'http://www.w3.org/2001/XMLSchema-instance'}

        try:
            results = elementpath.select(root, xPath, namespaces)
            if results is None or len(results) == 0:
                dictionary = self.get_properties_from_xpath(self, xPath)
                template_ids = dictionary["templatedId"]
                if template_ids is not None or len(template_ids) != 0:
                    base = xPath.split("[")[0]
                    predicates = ""
                    for templateId in template_ids[:-1]:
                        predicates += templateId + " and "
                    predicates += template_ids[-1]
                    _xPath = base + "[" + predicates + "]"
                    part_results = elementpath.select(root, _xPath, namespaces)

        except elementpath.exceptions.ElementPathSyntaxError:
            return self.ERROR

        if results is not None and len(results) != 0:
            return self.SATISFIED
        elif part_results is not None and len(part_results) != 0:
            return self.NOT_SATISFIED
        else:
            return self.NO_DATA



