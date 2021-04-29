import json
import glob
import shutil
import configparser
import os

BASE_DIR = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
configParser = configparser.RawConfigParser()
configFilePath = BASE_DIR + r'/config_file.cfg'
configParser.read(configFilePath)


def validate_json(s):
    try:
        json.loads(s)
    except Exception:
        return False
    return True


def delete_cache_files():
    #temp bugfix
    paths_to_delete = glob.glob(BASE_DIR + r'\cda_files\tempCache' + "/*")
    for path in paths_to_delete:
        print(path)
        shutil.rmtree(path, ignore_errors=True)

