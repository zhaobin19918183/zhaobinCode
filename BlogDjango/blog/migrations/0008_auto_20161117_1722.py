# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('blog', '0007_auto_20161117_1653'),
    ]

    operations = [
        migrations.RenameField(
            model_name='wxsmallprogram',
            old_name='number',
            new_name='numberid',
        ),
    ]
