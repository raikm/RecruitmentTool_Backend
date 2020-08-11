import unittest
from cdamanager.Evaluations import evaluate_request


class TestEvaluations(unittest.TestCase):

    def test_get_results(self):
        result = evaluate_request(221)



    if __name__ == '__main__':
        unittest.main()
