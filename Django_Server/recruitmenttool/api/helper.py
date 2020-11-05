import json
import glob
import shutil

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


def delete_cache_files():
    paths_to_delete = glob.glob("C:/Users/Raik Müller/Documents/GitHub/RecruitmentTool_Backend/Django_Server/recruitmenttool/cda_files/tempCache/*")
    for path in paths_to_delete:
        shutil.rmtree(path, ignore_errors=True)