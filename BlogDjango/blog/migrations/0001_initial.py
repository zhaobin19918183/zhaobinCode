# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
    ]

    operations = [
        migrations.CreateModel(
            name='addForm',
            fields=[
                ('id', models.AutoField(verbose_name='ID', serialize=False, auto_created=True, primary_key=True)),
                ('num', models.CharField(max_length=30, verbose_name=b'\xe5\xba\x8f\xe5\x8f\xb7')),
                ('kid', models.CharField(max_length=60, verbose_name=b'\xe6\x96\x87\xe4\xbb\xb6\xe5\x88\x86\xe7\xb1\xbb')),
                ('name', models.CharField(max_length=50, verbose_name=b'\xe6\x96\x87\xe4\xbb\xb6\xe5\x90\x8d\xe7\xa7\xb0')),
                ('gjz', models.CharField(max_length=50, verbose_name=b'\xe5\x85\xb3\xe9\x94\xae\xe5\xad\x97', blank=True)),
                ('fj', models.CharField(max_length=30, verbose_name=b'\xe9\x99\x84\xe4\xbb\xb6', blank=True)),
                ('status', models.CharField(max_length=60, verbose_name=b'\xe7\x8a\xb6\xe6\x80\x81')),
                ('where', models.CharField(max_length=30, verbose_name=b'\xe5\xad\x98\xe6\x94\xbe\xe4\xbd\x8d\xe7\xbd\xae')),
                ('headImg', models.FileField(upload_to=b'./upload', verbose_name=b'\xe4\xb8\x8a\xe4\xbc\xa0')),
                ('bz', models.CharField(max_length=50, verbose_name=b'\xe5\xa4\x87\xe6\xb3\xa8', blank=True)),
            ],
            options={
                'verbose_name': '\u6587\u4ef6\u76ee\u5f55',
                'verbose_name_plural': '\u6587\u4ef6\u76ee\u5f55',
            },
        ),
    ]
