# Generated by Django 3.0.4 on 2020-04-22 12:13

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('api', '0004_auto_20200422_1209'),
    ]

    operations = [
        migrations.AddField(
            model_name='cdafile',
            name='cda_id',
            field=models.IntegerField(default=123),
            preserve_default=False,
        ),
    ]