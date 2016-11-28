# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('blog', '0009_remove_wxsmallprogram_image'),
    ]

    operations = [
        migrations.RemoveField(
            model_name='wxsmallprogram',
            name='date',
        ),
    ]
