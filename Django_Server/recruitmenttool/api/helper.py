import json
import glob
import shutil
import configparser

configParser = configparser.RawConfigParser()
configFilePath = r'Django_Server/recruitmenttool/config_file.cfg'
configParser.read(configFilePath)


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
    paths_to_delete = glob.glob(configParser.get('temp-folders', 'cache') + "/*")
    for path in paths_to_delete:
        shutil.rmtree(path, ignore_errors=True)

