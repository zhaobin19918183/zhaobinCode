# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('polls', '0042_auto_20160912_0907'),
    ]

    operations = [
        migrations.AlterModelOptions(
            name='examinfo',
            options={'verbose_name': 'IOS', 'verbose_name_plural': 'IOS'},
        ),
    ]
