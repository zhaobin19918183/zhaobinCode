# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('polls', '0029_blogentry_image_upload'),
    ]

    operations = [
        migrations.RemoveField(
            model_name='blogentry',
            name='image_upload',
        ),
    ]
