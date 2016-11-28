# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import migrations, models
import filebrowser.fields


class Migration(migrations.Migration):

    dependencies = [
        ('polls', '0025_blogentry'),
    ]

    operations = [
        migrations.AlterField(
            model_name='blogentry',
            name='image',
            field=filebrowser.fields.FileBrowseField(max_length=500, null=True, verbose_name=b'Image', blank=True),
        ),
    ]
