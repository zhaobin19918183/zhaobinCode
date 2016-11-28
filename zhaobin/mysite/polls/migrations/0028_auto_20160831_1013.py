# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import migrations, models
import filebrowser.fields


class Migration(migrations.Migration):

    dependencies = [
        ('polls', '0027_auto_20160831_0930'),
    ]

    operations = [
        migrations.AlterField(
            model_name='blogentry',
            name='image',
            field=filebrowser.fields.FileBrowseField(max_length=500, null=True, verbose_name=b'Image', blank=True),
        ),
    ]
