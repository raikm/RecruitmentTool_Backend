import unittest
import os

from Django_Server.recruitmenttool.api.helper import *

BASE_DIR = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))

class TestHelper(unittest.TestCase):


    def test_validate_json(self):
        data_set = {"key1": [1, 2, 3], "key2": [4, 5, 6]}
        json_object = json.dumps(data_set)
        result = validate_json(json_object)
        self.assertEqual(bool, type(result), "Result is not a type of Bool")
        self.assertEqual(True, result, "Result is not 'True'")

    def test_validate_json_with_invalid_json(self):
        data_set = {"key1": [1, 2, 3], "key2": [4, 5, 6]}
        result = validate_json(data_set)
        self.assertEqual(bool, type(result), "Result is not a type of Bool")
        self.assertEqual(False, result, "Result is not 'False'")

    def test_cache_delete(self):
        cache_path = BASE_DIR + r'/cda_files/tempCache'
        #create temp directory
        os.mkdir(cache_path + "/temp_test_patient_0000")
        files_in_path = glob.glob(cache_path + "/*")
        self.assertEqual(1, len(files_in_path), "Directory should be not empty")

        delete_cache_files()
        files_in_path = glob.glob(cache_path + "/*")
        self.assertEqual(0, len(files_in_path), "Directory should be empty")

if __name__ == '__main__':
    unittest.main()
