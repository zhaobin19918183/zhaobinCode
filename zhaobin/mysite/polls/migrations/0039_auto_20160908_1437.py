# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('polls', '0038_auto_20160907_1537'),
    ]

    operations = [
        migrations.AlterField(
            model_name='examinfo',
            name='level',
            field=models.ImageField(upload_to=b'./upload', verbose_name=b'\xe7\xad\x89\xe7\xba\xa7', blank=True),
        ),
    ]
