# Generated by Django 3.0.4 on 2020-04-06 14:16

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    initial = True

    dependencies = [
    ]

    operations = [
        migrations.CreateModel(
            name='Criteria',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('name', models.CharField(max_length=100)),
                ('description', models.CharField(max_length=600)),
                ('date', models.DateTimeField()),
                ('only_current_patient_cohort', models.BooleanField()),
            ],
        ),
        migrations.CreateModel(
            name='Patient',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('title', models.CharField(max_length=30)),
                ('first_name', models.CharField(max_length=50)),
                ('middle_name', models.CharField(max_length=50)),
                ('last_name', models.CharField(max_length=50)),
                ('birthdate', models.DateField()),
            ],
        ),
        migrations.CreateModel(
            name='Criterium',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('name', models.CharField(max_length=100)),
                ('xPath', models.CharField(max_length=1000)),
                ('criteria', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='recruitmenttool.Criteria')),
            ],
        ),
        migrations.CreateModel(
            name='CDAFile',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('name', models.CharField(max_length=400)),
                ('path', models.CharField(max_length=400)),
                ('file', models.FileField(upload_to='cda_files')),
                ('file_date', models.DateTimeField()),
                ('upload_date', models.DateTimeField(auto_now=True)),
                ('patient', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='recruitmenttool.Patient')),
            ],
        ),
    ]
