from django.db import models


# Create your models here.

class InformationRequest(models.Model):
    name = models.CharField(max_length=60)
    xPath = models.CharField(max_length=60)
    #paths = models.ForeignKey(UploadFragment, on_delete=models.CASCADE)
    #updated_at = models.DateTimeField(auto_now=True)
    #created_at = models.DateTimeField(auto_now_add=True)
    def __str__(self):
        return self.name


class UploadFragment(models.Model):
    #file = models.FileField(upload_to='cda_files', blank=True)
    path = models.CharField(max_length=60)
    upload = models.ForeignKey(InformationRequest, on_delete=models.CASCADE)
