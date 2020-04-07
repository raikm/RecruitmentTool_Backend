from django.urls import include, path
from rest_framework import routers
from .views import create_new_criteria, criteria_detail

app_name = "recruitmenttool"


urlpatterns = [
    path('create/', create_new_criteria, name='create_new_criteria'),
    path("criteria/<int:pk>/", criteria_detail, name="criteria_detail"),
    path('api-auth/', include('rest_framework.urls', namespace='rest_framework'))
]
