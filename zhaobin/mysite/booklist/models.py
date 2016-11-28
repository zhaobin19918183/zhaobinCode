# -*- coding:UTF-8 -*- ＃必须在第一行或者第二行
# -*- coding:gb2312 -*- ＃必须在第一行或者第二行
# -*- coding:GBK -*- ＃必须在第一行或者第二行
import sys
reload(sys)
sys.setdefaultencoding("utf-8")
from django.db import models
#
class  carlist(models.Model):
    name = models.CharField(max_length=20,verbose_name="生产厂家")
    date = models.DateField(verbose_name="出厂时间")
    number = models.CharField(max_length=10,verbose_name="汽车名称")
    class Meta:
         verbose_name = "汽车4S"
         verbose_name_plural = "汽车4S"
    def __str__(self):
          return self.name
