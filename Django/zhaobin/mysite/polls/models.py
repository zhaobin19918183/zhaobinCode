# -*- coding:UTF-8 -*- ＃必须在第一行或者第二行
# -*- coding:gb2312 -*- ＃必须在第一行或者第二行
# -*- coding:GBK -*- ＃必须在第一行或者第二行
import datetime
from django.utils import timezone
from django.db import models
from django import forms
class Item(models.Model):
    name = models.CharField(max_length=250)
    description = models.TextField()

    class Meta:
        ordering = ['name']

    def __unicode__(self):
        return self.name

    @models.permalink
    def get_absolute_url(self):
        return ('item_detail', None, {'object_id': self.id})

class addForm(models.Model):
    num = models.CharField(max_length=30, verbose_name="序号")
    kid = models.CharField(max_length=60, verbose_name="文件分类")
    name = models.CharField(max_length=50, verbose_name="文件名称")
    gjz = models.CharField(max_length=50, verbose_name="关键字", blank=True)
    fj = models.CharField(max_length=30, verbose_name="附件", blank=True)
    status = models.CharField(max_length=60, verbose_name="状态")
    where = models.CharField(max_length=30, verbose_name="存放位置")
    headImg = models.FileField(upload_to='./upload', verbose_name="上传")
    bz = models.CharField(max_length=50, verbose_name="备注", blank=True)

    class Meta:
        verbose_name = "文件目录"
        verbose_name_plural = "文件目录"

    def __str__(self):
        return self.name
# Create your models here.
class ExamInfo(models.Model):
    name = models.CharField(max_length=10,verbose_name="用户名")
    level = models.CharField(max_length=10,verbose_name="等级")
    #改变 form 的名称
    class Meta:
        verbose_name = "注册"
        verbose_name_plural = "注册"

    def __str__(self):
        return self.name

class add(models.Model):
    item = models.ForeignKey(Item, on_delete=models.CASCADE)
    title = models.CharField(max_length=100)
    image = models.ImageField(upload_to='photos')
    caption = models.CharField(max_length=250, blank=True)





