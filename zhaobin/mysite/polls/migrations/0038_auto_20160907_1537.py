# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('polls', '0037_remove_examinfo_image'),
    ]

    operations = [
        migrations.AlterField(
            model_name='examinfo',
            name='level',
            field=models.ImageField(upload_to=b'', verbose_name=b'\xe7\xad\x89\xe7\xba\xa7', blank=True),
        ),
    ]
