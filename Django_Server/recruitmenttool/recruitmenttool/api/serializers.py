# serializers.py
from rest_framework import serializers
from .models import Study, Criterium, Condition, Patient, CDAFile, Information_Need


class ConditionSerializer(serializers.HyperlinkedModelSerializer):
    class Meta:
        model = Condition
        fields = ('name', 'xPath', 'value_xPath')


class CriteriumSerializer(serializers.HyperlinkedModelSerializer):
    conditions = ConditionSerializer(many=True, read_only=True)
    # criterium_type = serializers.CharField(max_length=200)
    # name = serializers.CharField(max_length=200)

    class Meta:
        model = Criterium
        fields = ('criterium_type', 'name', 'conditions')


class InformationNeedSerializer(serializers.HyperlinkedModelSerializer):
        model = Information_Need
        fields = ('name', 'xPath')


class StudySerializer(serializers.HyperlinkedModelSerializer):
    criteriums = CriteriumSerializer(many=True, read_only=True)
    information_needed = InformationNeedSerializer(many=True, read_only=True)

    class Meta:
        model = Study
        fields = ('name', 'description', 'date',
                  'only_current_patient_cohort', 'criteriums', 'information_needed')




class PatientSerializer(serializers.HyperlinkedModelSerializer):
    class Meta:
        model = Patient
        fields = ('title', 'first_name', 'middle_names',
                  'last_name', 'birthdate', 'patient_id')


class CDAFile(serializers.HyperlinkedModelSerializer):
    patient = PatientSerializer(many=False, read_only=True)

    class Meta:
        model = CDAFile
        fields = ('Name', 'Path', 'File', 'File_Date',
                  'Upload_Date', 'patient')
