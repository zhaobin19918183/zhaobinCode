# -*- coding:UTF-8 -*- ＃必须在第一行或者第二行
# -*- coding:gb2312 -*- ＃必须在第一行或者第二行
# -*- coding:GBK -*- ＃必须在第一行或者第二行
from django.conf.urls import patterns, url, include
from rest_framework import routers
from . import views
from .views import *
app_name = 'polls'

router = routers.DefaultRouter()
router.register(r'users', views.UserViewSet)
router.register(r'groups', views.GroupViewSet)
router.register(r'book', views.BookViewSet)
urlpatterns = [
     # 根据不同的方法向 URL 添加参数返回不同的数据

    url(r'^addForm_json/$',views.addForm_json),
    url(r'^form/$', views.home, name='home'),
    url(r'^home$', views.fileUpload),
    url(r'^html/$', views.testHtml),
    url(r'^book_json/$', views.book),
    url(r'^', include(router.urls)),
    url(r'^api-auth/', include('rest_framework.urls', namespace='rest_framework')),
    url(r'^register/$',registerNormalUser),



]

