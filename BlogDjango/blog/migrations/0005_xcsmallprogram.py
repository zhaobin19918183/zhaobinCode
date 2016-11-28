# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('blog', '0004_imageupload'),
    ]

    operations = [
        migrations.CreateModel(
            name='xcSmallProgram',
            fields=[
                ('id', models.AutoField(verbose_name='ID', serialize=False, auto_created=True, primary_key=True)),
                ('name', models.CharField(unique=True, max_length=15, verbose_name=b'\xe7\x94\xa8\xe6\x88\xb7\xe5\x90\x8d')),
                ('Image', models.ImageField(upload_to=b'', verbose_name=b'\xe5\xa4\xb4\xe5\x83\x8f', blank=True)),
                ('date', models.DateField(verbose_name=b'\xe6\xb3\xa8\xe5\x86\x8c\xe6\x97\xa5\xe6\x9c\x9f', blank=True)),
                ('address', models.CharField(max_length=100, verbose_name=b'\xe5\x9c\xb0\xe5\x9d\x80')),
                ('number', models.CharField(unique=True, max_length=18, verbose_name=b'\xe8\xba\xab\xe4\xbb\xbd\xe8\xaf\x81\xe5\x8f\xb7')),
                ('email', models.EmailField(max_length=254, verbose_name=b'\xe9\x82\xae\xe7\xae\xb1')),
            ],
            options={
                'verbose_name': '\u5fae\u4fe1\u5c0f\u7a0b\u5e8f',
                'verbose_name_plural': '\u5fae\u4fe1\u5c0f\u7a0b\u5e8f',
            },
        ),
    ]
