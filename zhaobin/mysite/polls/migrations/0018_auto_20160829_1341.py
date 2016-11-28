# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('polls', '0017_auto_20160829_1337'),
    ]

    operations = [
        migrations.AddField(
            model_name='examinfo',
            name='url_height',
            field=models.PositiveIntegerField(default=75),
        ),
        migrations.AddField(
            model_name='examinfo',
            name='url_width',
            field=models.PositiveIntegerField(default=75),
        ),
        migrations.AlterField(
            model_name='examinfo',
            name='level',
            field=models.ImageField(height_field=b'url_width', upload_to=b'', width_field=b'url_height', verbose_name=b'\xe6\x96\x87\xe4\xbb\xb6'),
        ),
    ]
