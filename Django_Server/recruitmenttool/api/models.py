from django.db import models


class Study(models.Model):
    name = models.CharField(max_length=100)
    head_of_study = models.CharField(
        max_length=600, blank=True, default='Keine Angabe')
    head_of_study_contact = models.CharField(
        max_length=800, blank=True, default='Keine Angaben')
    criterion_count = models.IntegerField()
    elga_criterion_count = models.IntegerField()
    eudraCT_number = models.CharField(
        max_length=800, blank=True, default='Keine Angaben')
    date = models.DateTimeField()

class Criterion(models.Model):
    criterion_type = models.CharField(max_length=100)
    name = models.CharField(max_length=100)
    study = models.ForeignKey(Study, related_name='criterions', on_delete=models.CASCADE)


class Condition(models.Model):
    name = models.CharField(max_length=100)
    xpath = models.CharField(max_length=1000)
    negative_xpath = models.CharField(max_length=1000, null=True, blank=True)
    rough_xpath = models.CharField(max_length=1000)
    rough_xpath_description = models.CharField(max_length=150)
    criterion = models.ForeignKey(Criterion, related_name='conditions', on_delete=models.CASCADE)


class Information_Need(models.Model):
    name = models.CharField(max_length=100)
    xpath = models.CharField(max_length=1000)
    study = models.ForeignKey(Study, related_name='information_needed', on_delete=models.CASCADE)


class Patient(models.Model):
    patient_id = models.IntegerField()
    patient_first_name = models.CharField(max_length=100)
    patient_last_name = models.CharField(max_length=100)
    studies = models.ManyToManyField(Study)


class Patient_Result(models.Model):
    study = models.ForeignKey(Study, related_name='patient_result', on_delete=models.CASCADE)
    patient = models.ForeignKey(Patient, related_name='patient_result', on_delete=models.CASCADE)
    patient_result = models.JSONField()



#class CDAFile(models.Model):
#    name = models.CharField(max_length=400)
#    cda_id = models.FloatField()
#    file = models.FileField(upload_to='Django_Server/recruitmenttool/cda_files')
#    file_date = models.DateTimeField()
#    upload_date = models.DateTimeField(auto_now=True)
#    patient = models.ForeignKey(
#        Patient, related_name='patient', on_delete=models.CASCADE)
