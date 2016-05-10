from django.forms import ModelForm
from polls.models import ExamInfo
class ExamInfoForm(ModelForm):
    class Meta:
        model = ExamInfo
        fields = '__all__'



