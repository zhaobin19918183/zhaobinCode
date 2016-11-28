from django.forms import ModelForm
from booklist.models import carlist
class CarForm(ModelForm):
    class Meta:
        model = carlist
        fields = '__all__'
