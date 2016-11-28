# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('blog', '0005_xcsmallprogram'),
    ]

    operations = [
        migrations.RenameModel(
            old_name='xcSmallProgram',
            new_name='wxSmallProgram',
        ),
    ]
