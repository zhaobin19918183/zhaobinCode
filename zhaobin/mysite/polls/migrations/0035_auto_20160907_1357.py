# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('polls', '0034_auto_20160906_1039'),
    ]

    operations = [
        migrations.AlterField(
            model_name='examinfo',
            name='level',
            field=models.TextField(verbose_name=b'\xe7\xad\x89\xe7\xba\xa7', blank=True),
        ),
    ]
