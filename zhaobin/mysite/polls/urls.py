# -*- coding:UTF-8 -*- ＃必须在第一行或者第二行
# -*- coding:gb2312 -*- ＃必须在第一行或者第二行
# -*- coding:GBK -*- ＃必须在第一行或者第二行
from django.conf.urls import url

from . import views
app_name = 'polls'
urlpatterns = [
     # 根据不同的方法向 URL 添加参数返回不同的数据
    url (r'^addForm_json/$',views.addForm_json),
    url (r'^test_json1/$',views.test_json1),

    url(r'^(?P<pk>[0-9]+)/$', views.DetailView.as_view(), name='detail'),
    url(r'^(?P<pk>[0-9]+)/results/$', views.ResultsView.as_view(), name='results'),
    url(r'^(?P<question_id>[0-9]+)/vote/$', views.vote, name='vote'),

    url(r'^form/$', views.home, name='home'),
    url(r'^app/$', views.homeApp),
    url(r'^html/$', views.testHtml),

]

