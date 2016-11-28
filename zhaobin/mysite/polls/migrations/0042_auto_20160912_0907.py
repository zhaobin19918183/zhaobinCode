# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('polls', '0041_auto_20160912_0904'),
    ]

    operations = [
        migrations.AlterModelOptions(
            name='normaluser',
            options={'ordering': ['username']},
        ),
    ]
