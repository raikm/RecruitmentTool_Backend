# serializers.py
from rest_framework import serializers
from .models import Study, Criterion, Condition, Information_Need, Patient, Patient_Result


class ConditionSerializer(serializers.HyperlinkedModelSerializer):
    class Meta:
        model = Condition
        fields = ('name', 'xpath', 'negative_xpath', 'rough_xpath', 'rough_xpath_description')


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
        fields = ('name', 'xpath')


class StudySerializer(serializers.HyperlinkedModelSerializer):
    criterions = CriterionSerializer(many=True, read_only=True)
    information_needed = InformationNeedSerializer(many=True, read_only=True)

    class Meta:
        model = Study
        fields = ('id', 'name', 'head_of_study', 'head_of_study_contact', 'criterion_count', 'elga_criterion_count', 'eudraCT_number', 'date',
                 'criterions', 'information_needed')


class PatientSerializer(serializers.HyperlinkedModelSerializer):
    class Meta:
        model = Patient
        fields = ('patient_id', 'patient_first_name', 'patient_last_name')


class PatientResultSerializer(serializers.HyperlinkedModelSerializer):
    study = StudySerializer(many=False, read_only=True)
    patient = PatientSerializer(many=False, read_only=True)
    class Meta:
        model = Patient_Result
        fields = ('study', 'patient', 'patient_result')

