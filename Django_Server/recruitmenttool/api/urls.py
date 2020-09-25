from django.urls import include, path
from .views import create_and_validate_new_study, all_studies, get_study, validate_saved_criteria, get_visualized_cda, prepare_test_data

app_name = "api"


urlpatterns = [
    path('create/', create_and_validate_new_study, name='create_new_criteria'),
    path('getAllStudies/', all_studies, name='all_studies'),
    path('getStudy/study_id=<int:study_id>', get_study, name='get_study'),
    path('getVisualizedCda/patient_id=<str:patient_id>/document_id=<str:document_id>', get_visualized_cda, name='get_visualized_cda'),
    path('prepareTestData/', prepare_test_data, name='prepare_test_data'),
    path('api-auth/', include('rest_framework.urls', namespace='rest_framework')),
    path('debug/', validate_saved_criteria, name='validate_saved_criteria')
]
