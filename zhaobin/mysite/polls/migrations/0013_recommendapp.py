# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('polls', '0012_auto_20160829_1108'),
    ]

    operations = [
        migrations.CreateModel(
            name='RecommendApp',
            fields=[
                ('id', models.AutoField(verbose_name='ID', serialize=False, auto_created=True, primary_key=True)),
                ('slider_image', models.ImageField(upload_to=b'slider', null=True, verbose_name=b'\xe5\xb9\xbb\xe7\x81\xaf\xe6\x88\xaa\xe5\x9b\xbe', blank=True)),
            ],
        ),
    ]
