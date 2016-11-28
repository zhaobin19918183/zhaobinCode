# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import migrations, models
import filebrowser.fields


class Migration(migrations.Migration):

    dependencies = [
        ('polls', '0026_auto_20160831_0927'),
    ]

    operations = [
        migrations.RemoveField(
            model_name='blogentry',
            name='document',
        ),
        migrations.AlterField(
            model_name='blogentry',
            name='image',
            field=filebrowser.fields.FileBrowseField(max_length=200, null=True, verbose_name=b'Image', blank=True),
        ),
    ]
