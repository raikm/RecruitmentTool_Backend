# Generated by Django 3.0.6 on 2020-11-02 15:31

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    initial = True

    dependencies = [
    ]

    operations = [
        migrations.CreateModel(
            name='Study',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('name', models.CharField(max_length=100)),
                ('description', models.CharField(blank=True, default='Keine Beschreibung', max_length=600)),
                ('date', models.DateTimeField()),
                ('only_current_patient_cohort', models.BooleanField()),
            ],
        ),
        migrations.CreateModel(
            name='Patient',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('patient_id', models.IntegerField()),
                ('patient_first_name', models.CharField(max_length=100)),
                ('patient_last_name', models.CharField(max_length=100)),
                ('studies_2', models.CharField(max_length=100)),
                ('studies', models.ManyToManyField(to='api.Study')),
            ],
        ),
        migrations.CreateModel(
            name='Information_Need',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('name', models.CharField(max_length=100)),
                ('xpath', models.CharField(max_length=1000)),
                ('study', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='information_needed', to='api.Study')),
            ],
        ),
        migrations.CreateModel(
            name='Criterion',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('criterion_type', models.CharField(max_length=100)),
                ('name', models.CharField(max_length=100)),
                ('study', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='criterions', to='api.Study')),
            ],
        ),
        migrations.CreateModel(
            name='Condition',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('name', models.CharField(max_length=100)),
                ('xpath', models.CharField(max_length=1000)),
                ('negative_xpath', models.CharField(max_length=1000)),
                ('rough_xpath', models.CharField(max_length=1000)),
                ('criterion', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='conditions', to='api.Criterion')),
            ],
        ),
    ]
