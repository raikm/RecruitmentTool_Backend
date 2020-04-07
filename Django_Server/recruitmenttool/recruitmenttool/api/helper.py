
def handle_uploaded_file(filename, f):
    with open('cda_files/'+ filename, 'wb+') as destination:
        for chunk in f.chunks():
            destination.write(chunk)
    return 'cda_files/'+ filename


def define_boolean(boolean_string):
    print("start")
    print(boolean_string)
    if boolean_string == "true":
        return True
    else: return False
