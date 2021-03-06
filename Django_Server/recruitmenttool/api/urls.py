from django.urls import include, path
from .views import create_or_edit_new_study, all_studies, get_study, validate_saved_criteria, get_visualized_cda, prepare_test_data, get_patients, save_selected_patients, get_selected_patients, validate_selected_cda_files

app_name = "api"


urlpatterns = [
    path('createOrEdit/', create_or_edit_new_study, name='create_or_edit_new_study'),
    path('getAllStudies/', all_studies, name='all_studies'),
    path('getAllPatients/', get_patients, name='get_patients'),
    path('saveSelectedPatients/', save_selected_patients, name='save_selected_patients'),
    path('getSelectedPatients/study_id=<int:study_id>', get_selected_patients, name='get_selected_patients'),
    path('getStudy/study_id=<int:study_id>', get_study, name='get_study'),
    path('getVisualizedCda/patient_id=<str:patient_id>/document_id=<str:document_id>', get_visualized_cda, name='get_visualized_cda'),
    path('prepareTestData/', prepare_test_data, name='prepare_test_data'),
    path('api-auth/', include('rest_framework.urls', namespace='rest_framework')),
    path('validateData/', validate_saved_criteria, name='validate_saved_criteria'),
    path('validateSelectedCdaFiles/', validate_selected_cda_files, name='validate_selected_cda_files')
]
