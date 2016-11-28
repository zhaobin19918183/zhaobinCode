# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('polls', '0040_normaluser'),
    ]

    operations = [
        migrations.AlterModelOptions(
            name='normaluser',
            options={'verbose_name': 'IOS', 'verbose_name_plural': 'IOS'},
        ),
    ]
