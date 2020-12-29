import lxml.etree


class XpathEvaluator:

    def validate_xpath(self, xpath):
        try:
            # if syntax wrong then exception raised
            lxml.etree.XPath(xpath)

            validated_xpath = self.remove_blankspaces(XpathEvaluator, xpath)
            return validated_xpath
        except lxml.etree.XPathSyntaxError:
            return ""

    def remove_blankspaces(self, xpath):
        return xpath.replace(" ", "")
