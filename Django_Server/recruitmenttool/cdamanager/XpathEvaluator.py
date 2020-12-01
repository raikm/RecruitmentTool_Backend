import lxml.etree


class XpathEvaluator:

    def validate_xpath(self, xpath):
        # if syntax wrong then exception raised
        lxml.etree.XPath(xpath)

        validated_xpath = self.remove_blankspaces(xpath)
        return validated_xpath

    def remove_blankspaces(self, xpath):
        return xpath.replace(" ", "")
