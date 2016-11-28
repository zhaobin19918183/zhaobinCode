# -*- coding:UTF-8 -*- ＃必须在第一行或者第二行
# -*- coding:gb2312 -*- ＃必须在第一行或者第二行
# -*- coding:GBK -*- ＃必须在第一行或者第二行
import sys
reload(sys)
sys.setdefaultencoding("utf-8")
from django.contrib.auth.models import User, Group
from rest_framework import serializers
from  .models import Article,wxSmallProgram


class UserSerializer(serializers.HyperlinkedModelSerializer):
        class Meta:
            model = User
            fields = ('url', 'username', 'email', 'groups')


class GroupSerializer(serializers.HyperlinkedModelSerializer):
        class Meta:
            model = Group
            fields = ('url', 'name')
class  ArticleSerializer(serializers.HyperlinkedModelSerializer):
        class Meta:
            model = Article
            fields = ('caption','subcaption','publish_time','update_time','update_time','content')
class wxSmallProgramSerializer(serializers.HyperlinkedModelSerializer):
        class Meta:
            model = wxSmallProgram
            fields = ('name', 'Image','date','address','number','email')

#,'author','classification','tags'