# Generated by Django 3.0.6 on 2020-10-27 13:29

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('api', '0002_patient'),
    ]

    operations = [
        migrations.AddField(
            model_name='patient',
            name='patient_first_name',
            field=models.CharField(default='nulllll', max_length=100),
            preserve_default=False,
        ),
        migrations.AddField(
            model_name='patient',
            name='patient_last_name',
            field=models.CharField(default='nulllll', max_length=100),
            preserve_default=False,
        ),
    ]
