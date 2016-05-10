# -*- coding:UTF-8 -*- ＃必须在第一行或者第二行
# -*- coding:gb2312 -*- ＃必须在第一行或者第二行
# -*- coding:GBK -*- ＃必须在第一行或者第二行
from django.shortcuts import render

# Create your views here.

from django.shortcuts import get_object_or_404, render
from django.http import HttpResponseRedirect, HttpResponse
from django.core.urlresolvers import reverse
from .models import Choice, Question,addForm,ExamInfo,Photo
from django.views import generic
from django.utils import timezone
import simplejson
from django.core import serializers
from polls.forms import ExamInfoForm
from django.views.decorators.csrf import csrf_exempt

from django.contrib.auth.models import User, Group
from rest_framework import viewsets


def vote(request, question_id):
    question = get_object_or_404(Question, pk=question_id)
    try:
        selected_choice = question.choice_set.get(pk=request.POST['choice'])

    except (KeyError, Choice.DoesNotExist):
        # Redisplay the question voting form.
        return render(request, 'polls/detail.html', {
            'question': question,
            'error_message': "You didn't select a choice.",
        })
    else:

        selected_choice.vote += 1
        # selected_name= "name"
        selected_choice.save()
        # Always return an HttpResponseRedirect after successfully dealing00000
        # with POST data. This prevents data from being posted twice if a
        # user hits the Back button.
        return HttpResponseRedirect(reverse('polls:results', args=(question.id,)))

class IndexView(generic.ListView):
    template_name = 'polls/index.html'
    context_object_name = 'latest_question_list'

    def get_queryset(self):
        """Return the last five published questions."""
        return Question.objects.order_by('-pub_date')[:5]

class DetailView(generic.DetailView):
    model = Question
    template_name = 'polls/detail.html'

class ResultsView(generic.DetailView):
    model = Question
    template_name = 'polls/results.html'

def get_queryset(self):
    """
    Return the last five published questions (not including those set to be
    published in the future).
    """
    return Question.objects.filter(
        pub_date__lte=timezone.now()
    ).order_by('-pub_date')[:5]
    # Json
class JsonTest( simplejson.JSONEncoder ):
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
   json_data = serializers.serialize("json",ExamInfo.objects.all())
   return  HttpResponse(json_data)

def test_json1(request):
   json_data = serializers.serialize("json",Photo.objects.all())
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









