# -*- coding:UTF-8 -*- ＃必须在第一行或者第二行
# -*- coding:gb2312 -*- ＃必须在第一行或者第二行
# -*- coding:GBK -*- ＃必须在第一行或者第二行
import sys

from PIL.ImageOps import grayscale

reload(sys)
sys.setdefaultencoding("utf-8")
from filebrowser.fields import FileBrowseField
from django.db import models

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
# Create your models here.
#IOS 上传文件部分
class ExamInfo(models.Model):
    name = models.CharField(max_length=10,verbose_name="用户名")
    level = models.ImageField(verbose_name="等级",blank=True,upload_to='./upload')

    #改变 form 的名称
    class Meta:
        verbose_name = "IOS"
        verbose_name_plural = "IOS"
    def __str__(self):
        return self.name
    def __unicode__(self):
        return self.name
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
class  booklist(models.Model):
    name = models.CharField(max_length=20,verbose_name="编号")
    date = models.DateField(verbose_name="出版时间")
    number = models.CharField(max_length=10,verbose_name="书籍名称")
    class Meta:
         verbose_name = "图书列表"
         verbose_name_plural = "图书列表"
    def __str__(self):
          return self.name
#photo
class BlogEntry(models.Model):
    imageNumber =  models.CharField(max_length=10,verbose_name="编号")
    image = FileBrowseField("图片名",max_length=500, directory="images/", extensions=[".jpg",".png"], blank=True, null=True)
    class Meta:
        verbose_name = "图片上传测试"
        verbose_name_plural = "图片上传测试"
class NormalUser(models.Model):
  username = models.CharField(max_length=30)
  headImg = models.FileField(upload_to='./upload')

  def __unicode__(self):
    return self.username

  class Meta:
    ordering = ['username']




