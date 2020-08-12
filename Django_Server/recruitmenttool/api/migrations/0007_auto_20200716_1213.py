# Generated by Django 3.0.4 on 2020-07-16 12:13

from django.db import migrations, models
import django.db.models.deletion
import django.utils.timezone


class Migration(migrations.Migration):

    dependencies = [
        ('api', '0006_auto_20200422_1218'),
    ]

    operations = [
        migrations.RenameField(
            model_name='criterium',
            old_name='criteria',
            new_name='study',
        ),
        migrations.RemoveField(
            model_name='criterium',
            name='xPath',
        ),
        migrations.AddField(
            model_name='criterium',
            name='criterium_type',
            field=models.CharField(default=django.utils.timezone.now, max_length=100),
            preserve_default=False,
        ),
        migrations.RenameModel(
            old_name='Criteria',
            new_name='Study',
        ),
        migrations.CreateModel(
            name='Information_Need',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('name', models.CharField(max_length=100)),
                ('xPath', models.CharField(max_length=1000)),
                ('study', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='information_needed', to='api.Study')),
            ],
        ),
        migrations.CreateModel(
            name='Condition',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('name', models.CharField(max_length=100)),
                ('xPath', models.CharField(max_length=1000)),
                ('value_xPath', models.CharField(max_length=1000)),
                ('criterium', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='conditions', to='api.Criterium')),
            ],
        ),
    ]
