# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('polls', '0022_auto_20160829_1417'),
    ]

    operations = [
        migrations.CreateModel(
            name='Photo',
            fields=[
                ('id', models.AutoField(verbose_name='ID', serialize=False, auto_created=True, primary_key=True)),
                ('title', models.CharField(max_length=100)),
                ('image', models.ImageField(upload_to=b'photos/originals/%Y/%m/')),
                ('image_height', models.IntegerField()),
                ('image_width', models.IntegerField()),
                ('thumbnail', models.ImageField(upload_to=b'photos/thumbs/%Y/%m/')),
                ('thumbnail_height', models.IntegerField()),
                ('thumbnail_width', models.IntegerField()),
                ('caption', models.CharField(max_length=250, blank=True)),
            ],
        ),
    ]
