from django.urls import include, path
from .views import create_new_criteria, criteria_detail, create_new_criteria_DEBUG

app_name = "api"


urlpatterns = [
    path('create/', create_new_criteria, name='create_new_criteria'),
    path('createDEBUG/', create_new_criteria_DEBUG, name='create_new_criteria_DEBUG'),
    path("criteria/<int:pk>/", criteria_detail, name="criteria_detail"),
    path('api-auth/', include('rest_framework.urls', namespace='rest_framework'))
]
