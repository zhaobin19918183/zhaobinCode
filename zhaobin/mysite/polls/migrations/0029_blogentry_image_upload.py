# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('polls', '0028_auto_20160831_1013'),
    ]

    operations = [
        migrations.AddField(
            model_name='blogentry',
            name='image_upload',
            field=models.ImageField(max_length=250, upload_to=b'./upload', null=True, verbose_name='Image (Upload)', blank=True),
        ),
    ]
