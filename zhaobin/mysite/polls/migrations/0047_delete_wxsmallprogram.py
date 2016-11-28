# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('polls', '0046_auto_20161117_1639'),
    ]

    operations = [
        migrations.DeleteModel(
            name='wxSmallProgram',
        ),
    ]
