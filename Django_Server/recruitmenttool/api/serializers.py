# serializers.py
from rest_framework import serializers
from .models import Criteria, Criterium, Patient, CDAFile


class CriteriumSerializer(serializers.HyperlinkedModelSerializer):
    class Meta:
        model = Criterium
        fields = ('name', 'xPath')


class CriteriaSerializer(serializers.HyperlinkedModelSerializer):
    criteriums = CriteriumSerializer(many=True, read_only=True)

    class Meta:
        model = Criteria
        fields = ('name', 'description', 'date',
                  'only_current_patient_cohort', 'criteriums')


class PatientmSerializer(serializers.HyperlinkedModelSerializer):
    class Meta:
        model = Patient
        fields = ('Title', 'First_Name', 'Middle_Name',
                  'Last_Name', 'Birthdate')


class CDAFile(serializers.HyperlinkedModelSerializer):
    patient = PatientmSerializer(many=False, read_only=True)

    class Meta:
        model = CDAFile
        fields = ('Name', 'Path', 'File', 'File_Date',
                  'Upload_Date', 'patient')
