# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import migrations, models
import filebrowser.fields


class Migration(migrations.Migration):

    dependencies = [
        ('polls', '0030_remove_blogentry_image_upload'),
    ]

    operations = [
        migrations.AddField(
            model_name='blogentry',
            name='imageNumber',
            field=models.CharField(default=1, max_length=10, verbose_name=b'\xe7\xbc\x96\xe5\x8f\xb7'),
            preserve_default=False,
        ),
        migrations.AlterField(
            model_name='blogentry',
            name='image',
            field=filebrowser.fields.FileBrowseField(max_length=500, null=True, verbose_name=b'\xe5\x9b\xbe\xe7\x89\x87\xe5\x90\x8d', blank=True),
        ),
    ]
