# Generated by Django 3.0.6 on 2020-11-15 10:21

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('api', '0007_remove_study_only_current_patient_cohort'),
    ]

    operations = [
        migrations.AddField(
            model_name='study',
            name='eudraCT_number',
            field=models.CharField(blank=True, default='Keine Angaben', max_length=800),
        ),
    ]
