# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('polls', '0045_auto_20161117_1633'),
    ]

    operations = [
        migrations.RemoveField(
            model_name='wxsmallprogram',
            name='Image',
        ),
        migrations.RemoveField(
            model_name='wxsmallprogram',
            name='date',
        ),
    ]
