# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('polls', '0035_auto_20160907_1357'),
    ]

    operations = [
        migrations.AddField(
            model_name='examinfo',
            name='image',
            field=models.ImageField(default=1, upload_to=b'', verbose_name=b'\xe7\x85\xa7\xe7\x89\x87'),
            preserve_default=False,
        ),
    ]
