# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('polls', '0020_auto_20160829_1415'),
    ]

    operations = [
        migrations.AlterField(
            model_name='examinfo',
            name='level',
            field=models.ImageField(upload_to=b'', width_field=True, height_field=True, blank=True, verbose_name=b'\xe6\x96\x87\xe4\xbb\xb6'),
        ),
    ]
