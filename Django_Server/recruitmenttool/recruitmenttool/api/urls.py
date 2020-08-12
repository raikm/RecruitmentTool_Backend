from django.urls import include, path
from .views import create_new_criteria, all_studies, get_study, validate_saved_criteria

app_name = "api"


urlpatterns = [
    path('create/', create_new_criteria, name='create_new_criteria'),
    path('getAllStudies/', all_studies, name='all_studies'),
    path('getStudy/study_id=<int:study_id>', get_study, name='get_study'),
    path('api-auth/', include('rest_framework.urls', namespace='rest_framework')),
    path('debug/', validate_saved_criteria, name='validate_saved_criteria')
]
