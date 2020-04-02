from django.urls import include, path
from rest_framework import routers
from . import views

router = routers.DefaultRouter()
router.register(r'informationRequests', views.InformationRequestViewSet)

# Wire up our API using automatic URL routing.
# Additionally, we include login URLs for the browsable API.
urlpatterns = [
    path('upload/', views.InformationRequestViewSet.post),
    #path('upload/', views.InformationRequestViewSet.post, name='create_to_feed'),
    path('api-auth/', include('rest_framework.urls', namespace='rest_framework'))
]
