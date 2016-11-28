# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('polls', '0036_examinfo_image'),
    ]

    operations = [
        migrations.RemoveField(
            model_name='examinfo',
            name='image',
        ),
    ]
