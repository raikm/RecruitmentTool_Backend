import json


def define_boolean(boolean_string):
    if boolean_string == "true":
        return True
    else:
        return False


def validate_json(s):
    try:
        json.loads(s)
    except Exception:
        return False
    return True
