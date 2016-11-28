# -*- coding:UTF-8 -*- ＃必须在第一行或者第二行
# -*- coding:gb2312 -*- ＃必须在第一行或者第二行
# -*- coding:GBK -*- ＃必须在第一行或者第二行

from django.db import models
class Tag(models.Model):
    tag_name = models.CharField(max_length=20)
    create_time = models.DateTimeField(auto_now_add=True)

    def __unicode__(self):
        return self.tag_name
class Classification(models.Model):
    name = models.CharField(max_length=20)

    def __unicode__(self):
        return self.name
class Author(models.Model):
    name    = models.CharField(max_length=30)
    email   = models.EmailField(blank=True)
    website = models.URLField(blank=True)

    def __unicode__(self):
        return u'%s' % (self.name)
class Article(models.Model):
    caption        = models.CharField(max_length=30)
    subcaption     = models.CharField(max_length=50, blank=True)
    publish_time   = models.DateTimeField(auto_now_add=True)
    update_time    = models.DateTimeField(auto_now=True)
    author         = models.ForeignKey(Author)
    classification = models.ForeignKey(Classification)
    tags           = models.ManyToManyField(Tag, blank=True)
    content        = models.TextField()
class ImageUpload(models.Model):
    #unique=True　检测是否重复(不允许重复)
    name = models.CharField(max_length=10,verbose_name="用户名",unique=True)
    Image = models.ImageField(verbose_name="头像",blank=True)
    #列表显示图片方法

    def admin_sample(self):
        return '<img src="/templates/%s" height="50" width="50" />' %(self.Image)
    admin_sample.short_description = '缩略图'
    admin_sample.allow_tags = True

    #改变 form 的名称
    class Meta:
        verbose_name = "图片预览"
        verbose_name_plural = "图片预览"
    def __str__(self):
        return self.name
class wxSmallProgram(models.Model):
    name    = models.CharField(max_length=15,verbose_name="用户名")
    address = models.CharField(verbose_name="地址",max_length=100)
    numberid  = models.CharField(max_length=18,verbose_name="身份证号")
    email   = models.EmailField(verbose_name="邮箱")
    class Meta:
          verbose_name = "微信小程序"
          verbose_name_plural = "微信小程序"
    def __str__(self):
        return self.name
    # def admin_sample(self):
    #     return '<img src="/templates/%s" height="50" width="50" />' %(self.Image)
    # admin_sample.short_description = '头像'
    # admin_sample.allow_tags = True