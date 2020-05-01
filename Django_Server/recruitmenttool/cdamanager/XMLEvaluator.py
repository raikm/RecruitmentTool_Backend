import os

class XMLEvaluator:

    def evaluate_file_type(file_path):
        filename, file_extension = os.path.splitext(str(file_path))
        if file_extension == "xml":
            return True
        else:
            return False
