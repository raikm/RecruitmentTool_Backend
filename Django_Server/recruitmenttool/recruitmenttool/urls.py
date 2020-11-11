"""recruitmenttool URL Configuration

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/3.0/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  path('', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  path('', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.urls import include, path
    2. Add a URL to urlpatterns:  path('blog/', include('blog.urls'))
"""
from django.contrib import admin
from django.urls import include, path
from py4j.java_gateway import JavaGateway

from cdamanager.CDAExtractor import CDAExtractor
import glob

app_name = "recruitmenttool"


urlpatterns = [
    path('admin/', admin.site.urls),
    path('api-auth/', include('rest_framework.urls', namespace='rest_framework')),
    #REST FRAMEWORK URLs
    path('api/', include('api.urls', namespace='api')),

    #emtpy = index
]


def startup():
    print("----------START-DJANGO-SERVER--v2--------\n")
    gateway = JavaGateway()                   # connect to the JVM
    xds_connector = gateway.entry_point
    xds_connector.testPythonConnection()
    cda_docs_path = """C:/Users/Raik Müller/Documents/GitHub/eHealthConnectorMiniAPI/src/main/resources/demoDocSource/*.xml"""
    stylesheet_path = """C:/Users/Raik Müller/Documents/GitHub/RecruitmentTool_Backend/Django_Server/recruitmenttool/cdamanager/Ressources/ELGA_Referenzstylesheet_1.09.001/ELGA_Stylesheet_v1.0.xsl"""
    oid = "1.2.40.0.10.1.4.3.1"
    id = ""
    # read CDAFile Step by Step
    for cda_file in glob.glob(cda_docs_path):
        extractor = CDAExtractor(cda_file)
        # TODO: read PatientId from CDA File // id = extension and oid = root
        # SVN
        id = extractor.get_patient_id()
        # fix value: (siehe Allgemeiner Leitfaden, Kapitel 6.3.1.2.2)

        documentId = extractor.get_document_id()
        #xds_connector.uploadDocument(oid, str(id), str(documentId), str(cda_file).split("\\")[1])
        # TODO: catch bad files where Data can't be read

    print("✓ - Data successfully uploaded to XDS Environment\n")

    #Test one download


startup()
