import os

class XMLEvaluator:

    def evaluate_file_type(file):
        if file.content_type == "text/xml":
            return True
        else:
            return False
