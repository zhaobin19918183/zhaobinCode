# -*- coding:UTF-8 -*- ＃必须在第一行或者第二行
# -*- coding:gb2312 -*- ＃必须在第一行或者第二行
# -*- coding:GBK -*- ＃必须在第一行或者第二行
from django.shortcuts import render

# Create your views here.

from django.shortcuts import get_object_or_404, render
from django.http import HttpResponseRedirect, HttpResponse
from django.core.urlresolvers import reverse
from .models import addForm,ExamInfo
from django.views import generic
from django.utils import timezone
import simplejson
from django.core import serializers
from polls.forms import ExamInfoForm
from django.views.decorators.csrf import csrf_exempt
from django.contrib.auth.models import User, Group
from rest_framework import viewsets


class JsonTest(simplejson.JSONEncoder ):
    """
    Encoding QuerySet into JSON format.
    """
    def default( self, object ):
        try:
            return serializers.serialize( "python", object,
                                          ensure_ascii = False )
        except:
            return simplejson.JSONEncoder.default( self, object )
# 定义转换 json 方法,调用接口返回的是数组
@csrf_exempt
def addForm_json(request):
   json_data = serializers.serialize("json",addForm.objects.all())
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
@csrf_exempt

def homeApp(request):
    p1 = request.GET.get('p1')
    p2 = request.GET.get('p2').replace(' ','+')
    print(p1)
    print(p2)
    form = ExamInfoForm({'name':p1,'level':p2})
    exam_info = form.save()
    exam_info.save()
    return HttpResponse('Thank you')
def testHtml(request):
    return  render(request,'polls/text.html')

def homeNew(request):
    if request.method == 'POST':
        form = ExamInfoFormNew(request.POST)
        if form.is_valid():
            exam_info = form.save()
            exam_info.save()
            return HttpResponse('Thank you')
    else:
        form = ExamInfoForm()
    return render(request, 'jlpt/index.html', {'form_info': form})