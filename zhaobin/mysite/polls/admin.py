from django.contrib import admin

from .models import Choice, Question,Image,Photo,Item,addForm
from polls.models import ExamInfo

class ChoiceInline(admin.TabularInline):
    model = Choice
    extra = 3


class QuestionAdmin(admin.ModelAdmin):
    fieldsets = [
        (None,               {'fields': ['question_text']}),
        ('Date information', {'fields': ['pub_date'], 'classes': ['collapse']}),
    ]
    inlines = [ChoiceInline]
    list_display = ('question_text', 'pub_date')
    list_display = ('question_text', 'pub_date', 'was_published_recently')
class ImageInline(admin.ModelAdmin):
    model = Image
    extra = 3

class PhotoInline(admin.StackedInline):
    model = Photo

class ItemAdmin(admin.ModelAdmin):

    inlines = [PhotoInline]

class ExamInfoAdmin(admin.ModelAdmin):
    list_display = ['name', 'level']


admin.site.register(ExamInfo, ExamInfoAdmin)
admin.site.register(addForm)
admin.site.register(Question, QuestionAdmin)
admin.site.register(Choice)
admin.site.register(Image)
admin.site.register(Photo)
admin.site.register(Item,ItemAdmin)



