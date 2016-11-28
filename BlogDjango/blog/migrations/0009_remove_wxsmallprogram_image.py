# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('blog', '0008_auto_20161117_1722'),
    ]

    operations = [
        migrations.RemoveField(
            model_name='wxsmallprogram',
            name='Image',
        ),
    ]
