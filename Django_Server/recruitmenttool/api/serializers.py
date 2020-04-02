# serializers.py
from rest_framework import serializers

from .models import InformationRequest, UploadFragment

class InformationRequestSerializer(serializers.HyperlinkedModelSerializer):
    class Meta:
        model = InformationRequest
        fields = ('name', 'xPath')#TODO:  timestamp


# class UploadFragmentSerializer(serializers.HyperlinkedModelSerializer):
#     class Meta:
#         model = UploadFragment
#         fields = ('path', 'upload')
