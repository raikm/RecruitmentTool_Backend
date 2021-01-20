import json
import glob
import shutil
import configparser

configParser = configparser.RawConfigParser()
configFilePath = r'Django_Server/recruitmenttool/config_file.cfg'
configParser.read(configFilePath)


def validate_json(s):
    try:
        json.loads(s)
    except Exception:
        return False
    return True


def delete_cache_files():
    #temp bugfix
    paths_to_delete = glob.glob(r'C:\Users\Raik Müller\Documents\GitHub\RecruitmentTool_Backend\Django_Server\recruitmenttool\cda_files\tempCache' + "/*")
    for path in paths_to_delete:
        print(path)
        shutil.rmtree(path, ignore_errors=True)

