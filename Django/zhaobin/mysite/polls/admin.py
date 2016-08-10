from django.contrib import admin
from .models import addForm,add
from polls.models import ExamInfo


class ExamInfoAdmin(admin.ModelAdmin):
    list_display = ['name', 'level']


admin.site.register(ExamInfo, ExamInfoAdmin)
admin.site.register(addForm)
admin.site.register(add)





