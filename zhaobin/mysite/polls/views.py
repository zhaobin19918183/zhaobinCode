# -*- coding:UTF-8 -*- ＃必须在第一行或者第二行
# -*- coding:gb2312 -*- ＃必须在第一行或者第二行
# -*- coding:GBK -*- ＃必须在第一行或者第二行
# Create your views here.
#-*- encoding:gb2312 -*-
from django.shortcuts import  render
from django.http import HttpResponse
from .models import addForm,booklist,NormalUser,ExamInfo
import simplejson
from django.core import serializers
from .forms import ExamInfoForm,BookList
from django.views.decorators.csrf import csrf_exempt
from django.contrib.auth.models import User, Group
from rest_framework import viewsets
from serializers import UserSerializer,GroupSerializer,booklistSerializer
from django import forms

class JsonTest(simplejson.JSONEncoder ):
    """
    Encoding QuerySet into JSON format.
    """
    def default( self, object ):
        try:
            return serializers.serialize("python", object,
                                          ensure_ascii = False )
        except:
            return simplejson.JSONEncoder.default(self, object )
# 定义转换 json 方法,调用接口返回的是数组
@csrf_exempt
def addForm_json(request):
   json_data = serializers.serialize("json",addForm.objects.all())
   return  HttpResponse(json_data)
# 重名function 不能与 class 重名
def book_json(request):
    print(request)
    json_data = serializers.serialize("json",booklist.objects.all())
    return  HttpResponse(json_data)
def home(request):
    if request.method == 'POST':
        form = ExamInfoForm(request.POST)
        if form.is_valid():
            exam_info = form.save()
            exam_info.save()
            return HttpResponse('Thank you')
    else:
        form = ExamInfoForm()
    return render(request, 'polls/message.html', {'form_info': form})
def testHtml(request):
    return  render(request,'polls/text.html')
@csrf_exempt
def book(request):

    if request.method == 'POST':
        form = BookList(request.POST)
        if form.is_valid():
            exam_info = form.save()
            exam_info.save()
            return HttpResponse('Thank you')
    else:
        form = BookList()
    return render(request, 'polls/results.html', {'form_info': form})
# 封装 api
class BookViewSet(viewsets.ModelViewSet):
        """
        允许查看和编辑Book的 API endpoint
        """
        queryset = booklist.objects.all()
        serializer_class = booklistSerializer
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
        #
#html
class NormalUserForm(forms.Form):
  username = forms.CharField()
  headImg  = forms.FileField()
def registerNormalUser(request):
  if request.method == "POST":
    uf = NormalUserForm(request.POST,request.FILES)
    if uf.is_valid():
      # get the info of the form  cleaned_data :处理或得到的数据,让 username 和 uf 获得数据类型一致
      username = uf.cleaned_data['username']
      headImg = uf.cleaned_data['headImg']
      # write in database
      normalUser = NormalUser()
      normalUser.username = username
      normalUser.headImg = headImg
      normalUser.save()
      return HttpResponse('Upload Succeed!')
  else:
    uf = NormalUserForm()
  return render(request,'polls/register.html',{'uf':uf})
#文件存储 ios
@csrf_exempt
#逻辑判断
def fileUpload(request):

  if request.method   == 'POST':
    name              = request.POST.get('name')
    #files 是上传的文件流通过对应的参数名获取
    image             = request.FILES.get('image')
    filesUpload       = ExamInfo()
    filesUpload.level = image
    filesUpload.name  = name
    filesUpload.save()
    return HttpResponse('success')

