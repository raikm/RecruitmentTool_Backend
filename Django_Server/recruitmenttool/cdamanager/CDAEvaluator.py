import xml.etree.ElementTree as ET
import elementpath
#source: https://eulxml.readthedocs.io/en/latest/xpath.html
import eulxml.xpath
import re

class CDAEvaluator:
    SATISFIED = "SATISFIED"
    NOT_SATISFIED = "NOT_SATISFIED"
    NO_DATA = "NO_DATA"
    ERROR = "ERROR"

    # TODO: Refactor
    def get_properties_from_ast(n):
        OPERATOR_MAPPING = {'and', 'not', 'or'}
        COMPARISON_MAPPING = {'>', '>=', '<', '<=', "=", "!="}

        dictionary = dict()
        global nodeList
        try:
            nodeList = n.relative.predicates
        except AttributeError:
            print("AttributeError while parsing basic path")

        templateList = []
        if nodeList is not None:
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

    def get_root_from_xml(self, cda_file):
        # TODO: valid XML?
        if type(cda_file) != str:
            cda_file.seek(0)
        try:
            tree = ET.parse(cda_file)
        except FileNotFoundError:
            print("FILE NOT FOUND") #TODO: better error handling

        return tree.getroot()

    def evaluate_cda_file_Etree(self, xPath, cda_file):
        try:
            root = self.get_root_from_xml(self, cda_file)
        except:
            return self.ERROR

        namespaces = {'': 'urn:hl7-org:v3'}

        #TODO: Refactor
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



