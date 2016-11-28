from django.forms import ModelForm
from django import  forms
from .models import ExamInfo,booklist
class ExamInfoForm(ModelForm):
    class Meta:
        model = ExamInfo
        fields = '__all__'

class BookList(ModelForm):
    class Meta:
        model = booklist
        fields='__all__'
