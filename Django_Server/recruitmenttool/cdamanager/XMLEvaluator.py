

class XMLEvaluator:


    def evaluate_file_type(self, file):
        if file.content_type == "text/xml":
            return True
        else:
            return False
