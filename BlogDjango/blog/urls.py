# -*- coding:UTF-8 -*- ＃必须在第一行或者第二行
# -*- coding:gb2312 -*- ＃必须在第一行或者第二行
# -*- coding:GBK -*- ＃必须在第一行或者第二行
from django.conf.urls import  url, include
from rest_framework import routers
from . import views
from .views import *
app_name = 'blog'
router = routers.DefaultRouter()
router.register(r'users', views.UserViewSet)
router.register(r'groups', views.GroupViewSet)
router.register(r'Article', views.ArticleViewSet)
router.register(r'wxSmallProgram', views.wxSmallProgramSet)
urlpatterns = [
     # 根据不同的方法向 URL 添加参数返回不同的数据
    url(r'^', include(router.urls)),
    url(r'^index/$', 'blog.views.blog_list', name='blog_list'),
    url(r'^comments/', include('django_comments.urls')),
    url(r'^detail/$', 'blog.views.blog_detail', name='blog_detail'),
    url(r'^home', views.fileUpload),
    url(r'^register/$', views.register),
    url(r'^wxSmall$',wxSmall),


]
