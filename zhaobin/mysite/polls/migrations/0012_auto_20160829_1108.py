# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('polls', '0011_auto_20160829_0934'),
    ]

    operations = [
        migrations.AlterField(
            model_name='examinfo',
            name='level',
            field=models.ImageField(upload_to=b'./upload', null=True, verbose_name=b'\xe6\x96\x87\xe4\xbb\xb6', blank=True),
        ),
    ]