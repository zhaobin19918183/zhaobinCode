# -*- coding:UTF-8 -*- ＃必须在第一行或者第二行
# -*- coding:gb2312 -*- ＃必须在第一行或者第二行
# -*- coding:GBK -*- ＃必须在第一行或者第二行
import datetime
from django.utils import timezone
from django.db import models
class Question(models.Model):
    question_text = models.CharField(max_length=200)
    pub_date = models.DateTimeField('date published')

    def __str__(self):
        return self.question_text

    def was_published_recently(self):
        return self.pub_date >= timezone.now() - datetime.timedelta(days=1)

    was_published_recently.admin_order_field = 'pub_date'
    was_published_recently.boolean = True
    was_published_recently.short_description = 'Published recently?'

    # def was_published_recently(self):
    #     return self.pub_date >= timezone.now() - datetime.timedelta(days=1)
    def was_published_recently(self):
        now = timezone.now()
        return now - datetime.timedelta(days=1) <= self.pub_date <= now


class Choice(models.Model):
    question = models.ForeignKey(Question, on_delete=models.CASCADE)
    choice_text = models.CharField(max_length=200)
    vote = models.IntegerField(default=0)

    def __str__(self):
        return self.choice_text


class Image(models.Model):
    def __str__(self):
        return "Image"


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


class Photo(models.Model):
    item = models.ForeignKey(Item, on_delete=models.CASCADE)
    title = models.CharField(max_length=100)
    image = models.ImageField(upload_to='photos')
    caption = models.CharField(max_length=250, blank=True)

    class Meta:
        ordering = ["title"]

    def __unicode__(self):
        return self.title

    @models.permalink
    def get_absolute_url(self):
        return ('photo_detail', None, {'object_id': self.id})


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
    name = models.CharField(max_length=10)
    level = models.TextField()
