# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('polls', '0018_auto_20160829_1341'),
    ]

    operations = [
        migrations.RemoveField(
            model_name='examinfo',
            name='url_height',
        ),
        migrations.RemoveField(
            model_name='examinfo',
            name='url_width',
        ),
        migrations.AlterField(
            model_name='examinfo',
            name='level',
            field=models.ImageField(upload_to=b'', verbose_name=b'\xe6\x96\x87\xe4\xbb\xb6'),
        ),
    ]
