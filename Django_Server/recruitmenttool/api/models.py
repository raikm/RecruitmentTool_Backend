from django.db import models


class Criteria(models.Model):
    name = models.CharField(max_length=100)  # Todo: limitieren in FrontEnd
    description = models.CharField(
        max_length=600, blank=True, default='Keine Beschreibung')
    date = models.DateTimeField()
    only_current_patient_cohort = models.BooleanField()


class Criterium(models.Model):
    name = models.CharField(max_length=100)
    xPath = models.CharField(max_length=1000)
    criteria = models.ForeignKey(
        Criteria, related_name='criteriums', on_delete=models.CASCADE)


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
    file = models.FileField(upload_to='cda_files')
    file_date = models.DateTimeField()
    upload_date = models.DateTimeField(auto_now=True)
    patient = models.ForeignKey(
        Patient, related_name='patient', on_delete=models.CASCADE)
