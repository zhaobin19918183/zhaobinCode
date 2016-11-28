# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('polls', '0033_examinfo_image'),
    ]

    operations = [
        migrations.RemoveField(
            model_name='examinfo',
            name='image',
        ),
        migrations.AlterField(
            model_name='examinfo',
            name='level',
            field=models.CharField(max_length=10, verbose_name=b'\xe7\xad\x89\xe7\xba\xa7', blank=True),
        ),
    ]
