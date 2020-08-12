from django.db import models


class Study(models.Model):
    name = models.CharField(max_length=100)  # Todo: limitieren in FrontEnd
    description = models.CharField(
        max_length=600, blank=True, default='Keine Beschreibung')
    date = models.DateTimeField()
    only_current_patient_cohort = models.BooleanField() #TODO: per default in FrontEnd


class Criterium(models.Model):
    criterium_type = models.CharField(max_length=100)
    name = models.CharField(max_length=100)
    study = models.ForeignKey(Study, related_name='criteriums', on_delete=models.CASCADE)


class Condition(models.Model):
    name = models.CharField(max_length=100)
    xPath = models.CharField(max_length=1000)
    value_xPath = models.CharField(max_length=1000)
    criterium = models.ForeignKey(Criterium, related_name='conditions', on_delete=models.CASCADE)


class Information_Need(models.Model):
    name = models.CharField(max_length=100)
    xPath = models.CharField(max_length=1000)
    study = models.ForeignKey(Study, related_name='information_needed', on_delete=models.CASCADE)


class Patient(models.Model):
    title = models.CharField(max_length=30)
    first_name = models.CharField(max_length=50)
    middle_names = models.CharField(max_length=50) #TODO: change to list
    last_name = models.CharField(max_length=50)
    birthdate = models.DateField()
    patient_id = models.IntegerField()


class CDAFile(models.Model):
    name = models.CharField(max_length=400)
    cda_id = models.FloatField()
    file = models.FileField(upload_to='Django_Server/recruitmenttool/cda_files')
    file_date = models.DateTimeField()
    upload_date = models.DateTimeField(auto_now=True)
    patient = models.ForeignKey(
        Patient, related_name='patient', on_delete=models.CASCADE)
