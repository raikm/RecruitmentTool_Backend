# serializers.py
from rest_framework import serializers
from .models import Study, Criterion, Condition, Information_Need, Patient #Patient, CDAFile,


class ConditionSerializer(serializers.HyperlinkedModelSerializer):
    class Meta:
        model = Condition
        fields = ('name', 'xpath', 'negative_xpath', 'rough_xpath')


class CriterionSerializer(serializers.HyperlinkedModelSerializer):
    conditions = ConditionSerializer(many=True, read_only=True)
    # criterium_type = serializers.CharField(max_length=200)
    # name = serializers.CharField(max_length=200)

    class Meta:
        model = Criterion
        fields = ('criterion_type', 'name', 'conditions')


class InformationNeedSerializer(serializers.HyperlinkedModelSerializer):
    class Meta:
        model = Information_Need
        fields = ('name', 'xPath')


class StudySerializer(serializers.HyperlinkedModelSerializer):
    criterions = CriterionSerializer(many=True, read_only=True)
    information_needed = InformationNeedSerializer(many=True, read_only=True)

    class Meta:
        model = Study
        fields = ('name', 'description', 'date',
                  'only_current_patient_cohort', 'criterions', 'information_needed')


class PatientSerializer(serializers.HyperlinkedModelSerializer):
    class Meta:
        model = Patient
        fields = ('patient_id', 'patient_first_name', 'patient_last_name')

#
# class CDAFile(serializers.HyperlinkedModelSerializer):
#     patient = PatientSerializer(many=False, read_only=True)
#
#     class Meta:
#         model = CDAFile
#         fields = ('Name', 'Path', 'File', 'File_Date',
#                   'Upload_Date', 'patient')
