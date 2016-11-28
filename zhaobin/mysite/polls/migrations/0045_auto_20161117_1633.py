# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('polls', '0044_wxsmallprogram'),
    ]

    operations = [
        migrations.AlterField(
            model_name='wxsmallprogram',
            name='Image',
            field=models.ImageField(upload_to=b'', verbose_name=b'\xe5\xa4\xb4\xe5\x83\x8f'),
        ),
        migrations.AlterField(
            model_name='wxsmallprogram',
            name='date',
            field=models.DateField(verbose_name=b'\xe6\xb3\xa8\xe5\x86\x8c\xe6\x97\xa5\xe6\x9c\x9f'),
        ),
        migrations.AlterField(
            model_name='wxsmallprogram',
            name='name',
            field=models.CharField(max_length=15, verbose_name=b'\xe7\x94\xa8\xe6\x88\xb7\xe5\x90\x8d'),
        ),
        migrations.AlterField(
            model_name='wxsmallprogram',
            name='number',
            field=models.CharField(max_length=18, verbose_name=b'\xe8\xba\xab\xe4\xbb\xbd\xe8\xaf\x81\xe5\x8f\xb7'),
        ),
    ]
