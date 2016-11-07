# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('blog', '0002_auto_20161107_1331'),
    ]

    operations = [
        migrations.DeleteModel(
            name='addForm',
        ),
    ]
