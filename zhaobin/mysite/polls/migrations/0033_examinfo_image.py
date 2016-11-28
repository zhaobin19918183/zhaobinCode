# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import migrations, models
import filebrowser.fields


class Migration(migrations.Migration):

    dependencies = [
        ('polls', '0032_auto_20160831_1049'),
    ]

    operations = [
        migrations.AddField(
            model_name='examinfo',
            name='image',
            field=filebrowser.fields.FileBrowseField(max_length=500, null=True, verbose_name=b'\xe5\x9b\xbe\xe7\x89\x87\xe5\x90\x8d', blank=True),
        ),
    ]
