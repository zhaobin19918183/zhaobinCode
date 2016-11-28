# -*- coding:UTF-8 -*- ＃必须在第一行或者第二行
# -*- coding:gb2312 -*- ＃必须在第一行或者第二行
# -*- coding:GBK -*- ＃必须在第一行或者第二行
# Create your views here.
#-*- encoding:gb2312 -*-
from django.shortcuts import render
from django.contrib.auth.models import User, Group
from rest_framework import viewsets
from django.views.decorators.csrf import csrf_exempt
from serializers import UserSerializer,GroupSerializer,ArticleSerializer,wxSmallProgramSerializer
from blog.models import Article,ImageUpload,wxSmallProgram
from django.shortcuts import render_to_response
from django.template import RequestContext
from django.http import Http404
from django.http import HttpResponse
from django import forms
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
class ArticleViewSet(viewsets.ModelViewSet):
        """
        允许查看和编辑Article的 API endpoint
        """
        queryset = Article.objects.all()
        serializer_class = ArticleSerializer
class wxSmallProgramSet(viewsets.ModelViewSet):
        """
        允许查看和编辑Article的 API endpoint
        """
        queryset = wxSmallProgram.objects.all()
        serializer_class = wxSmallProgramSerializer
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
@csrf_exempt
def fileUpload(request):
  if request.method   == 'POST':
    name              = request.POST.get('name')
    #files 是上传的文件流通过对应的参数名获取
    image             = request.FILES.get('image')
    filesUpload       = ImageUpload()
    filesUpload.Image = image
    filesUpload.name  = name
    filesUpload.save()
    return HttpResponse('success')
class UserForm(forms.Form):
    username  = forms.CharField(label='用户名：',max_length=100)
    passworld = forms.CharField(label='密码：',max_length=52)
    email     = forms.EmailField(label='电子邮件：')
# Create your views here.
def register(request):
    if request.method == "POST":
        uf = UserForm(request.POST)
        if uf.is_valid():
            #获取表单信息
            username = uf.cleaned_data['username']
            passworld = uf.cleaned_data['passworld']
            email = uf.cleaned_data['email']
            #将表单写入数据库
            user = User.objects.create_superuser(username,email,passworld)
            if user.is_staff:
             print ("注册失败")
            else:
             user.save()
            return HttpResponse('success')
    else:
        uf = UserForm()
    return render(request,'register.html',{'uf':uf})
@csrf_exempt
def wxSmall(request):
    print(request.method)
    if request.method == "POST":
      print(request.POST.get)
      name    = request.POST.get('name')
      address = request.POST.get('address')
      number  = request.POST.get('numberid')
      email   = request.POST.get('email')
      wx      = wxSmallProgram()
      print(name)
      print(address)
      wx.name = name
      wx.address = address
      wx.numberid = number
      wx.email = email
      wx.save()
    return HttpResponse('success')
