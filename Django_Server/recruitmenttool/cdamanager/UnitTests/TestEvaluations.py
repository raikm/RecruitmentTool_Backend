import unittest

import requests

from CDAExtractor import CDAExtractor
from datetime import datetime

class TestEvaluations(unittest.TestCase):

    def test_get_results(self):
        try:
            address = "http://192.168.0.71:8000/api/debug/"
            response = requests.get(address)
            print(response.text)
        except Exception as e:
            print(e)


    if __name__ == '__main__':
        unittest.main()
