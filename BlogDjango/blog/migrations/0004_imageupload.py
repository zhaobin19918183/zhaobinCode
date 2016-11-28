# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('blog', '0003_delete_addform'),
    ]

    operations = [
        migrations.CreateModel(
            name='ImageUpload',
            fields=[
                ('id', models.AutoField(verbose_name='ID', serialize=False, auto_created=True, primary_key=True)),
                ('name', models.CharField(unique=True, max_length=10, verbose_name=b'\xe7\x94\xa8\xe6\x88\xb7\xe5\x90\x8d')),
                ('Image', models.ImageField(upload_to=b'', verbose_name=b'\xe5\xa4\xb4\xe5\x83\x8f', blank=True)),
            ],
            options={
                'verbose_name': '\u56fe\u7247\u9884\u89c8',
                'verbose_name_plural': '\u56fe\u7247\u9884\u89c8',
            },
        ),
    ]
