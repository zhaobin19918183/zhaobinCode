# -*- coding:UTF-8 -*- ＃必须在第一行或者第二行
# -*- coding:gb2312 -*- ＃必须在第一行或者第二行
# -*- coding:GBK -*- ＃必须在第一行或者第二行
from django.conf.urls import url

from . import views
app_name = 'polls'
urlpatterns = [
     # 根据不同的方法向 URL 添加参数返回不同的数据
    url (r'^addForm_json/$',views.addForm_json),
    url (r'^test_json1/$',views.addForm_json),
    url(r'^form/$', views.home, name='home'),
    url(r'^home/$', views.home),
    url(r'^html/$', views.testHtml),

]

