# -*- coding: utf-8 -*-
# Generated by Django 1.9.1 on 2016-02-16 02:19
from __future__ import unicode_literals

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('polls', '0009_delete_contactform'),
    ]

    operations = [
        migrations.CreateModel(
            name='ExamInfo',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('name', models.CharField(max_length=10)),
                ('level', models.CharField(choices=[(b'N1', b'N1'), (b'N2', b'N2'), (b'N3', b'N3'), (b'N4', b'N4'), (b'N5', b'N5'), (b'NO', b'NO')], max_length=2)),
            ],
        ),
    ]