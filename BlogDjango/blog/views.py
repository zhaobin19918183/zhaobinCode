# -*- coding:UTF-8 -*- ＃必须在第一行或者第二行
# -*- coding:gb2312 -*- ＃必须在第一行或者第二行
# -*- coding:GBK -*- ＃必须在第一行或者第二行
# Create your views here.
#-*- encoding:gb2312 -*-
from django.shortcuts import render
from django.contrib.auth.models import User, Group
from rest_framework import viewsets
from serializers import UserSerializer,GroupSerializer
from blog.models import Article, Tag, Classification
from django.shortcuts import render_to_response
from django.template import RequestContext
from django.http import Http404
# Create your views here.
class UserViewSet(viewsets.ModelViewSet):
        """
        允许查看和编辑user 的 API endpoint
        """
        queryset = User.objects.all()
        serializer_class = UserSerializer
class GroupViewSet(viewsets.ModelViewSet):
        """
        允许查看和编辑group的 API endpoint
        """
        queryset = Group.objects.all()
        serializer_class = GroupSerializer
def blog_list(request):
    blogs = Article.objects.all().order_by('-publish_time')
    return render_to_response('index.html', {"blogs": blogs},context_instance=RequestContext(request))
def blog_detail(request):
    if request.method == 'GET':
        id = request.GET.get('id', '');

        try:
            blog = Article.objects.get(id=id)

        except Article.DoesNotExist:
            raise Http404
        return render_to_response("detail.html", {"blog": blog}, context_instance=RequestContext(request))
    else:
        raise Http404