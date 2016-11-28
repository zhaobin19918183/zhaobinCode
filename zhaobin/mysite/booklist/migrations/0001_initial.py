# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
    ]

    operations = [
        migrations.CreateModel(
            name='carlist',
            fields=[
                ('id', models.AutoField(verbose_name='ID', serialize=False, auto_created=True, primary_key=True)),
                ('name', models.CharField(max_length=20, verbose_name=b'\xe7\x94\x9f\xe4\xba\xa7\xe5\x8e\x82\xe5\xae\xb6')),
                ('date', models.DateField(verbose_name=b'\xe5\x87\xba\xe5\x8e\x82\xe6\x97\xb6\xe9\x97\xb4')),
                ('number', models.CharField(max_length=10, verbose_name=b'\xe6\xb1\xbd\xe8\xbd\xa6\xe5\x90\x8d\xe7\xa7\xb0')),
            ],
            options={
                'verbose_name': '\u6c7d\u8f664S',
                'verbose_name_plural': '\u6c7d\u8f664S',
            },
        ),
    ]
