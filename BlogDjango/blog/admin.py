# -*- coding:UTF-8 -*- ＃必须在第一行或者第二行
# -*- coding:gb2312 -*- ＃必须在第一行或者第二行
# -*- coding:GBK -*- ＃必须在第一行或者第二行
from django.contrib import admin
from  .models import Tag,Classification,Article,Author,ImageUpload,wxSmallProgram

# Register your models here.

class ArticleAdmin(admin.ModelAdmin):
     list_display = ['author', 'publish_time']
class ImageUploadAdmin(admin.ModelAdmin):
     list_display = ['name', 'admin_sample']
     list_per_page = 10
class wxSmallProgramAdmin(admin.ModelAdmin):
     list_display = ['name','numberid']  #指定要显示的字段
     search_fields = ['name']#指定要搜索的字段，将会出现一个搜索框让管理员搜索关键词
     list_filter = ['numberid'] #指定列表过滤器，右边将会出现一个快捷的日期过滤选项，
       #以方便开发人员快速地定位到想要的数据，同样你也可以指定非日期型类型的字段
     # fields = ['name','date','number'] #自定义编辑表单，在编辑表单的时候 显示哪些字段，显示的属性
     # ordering = ('-birth','age')           #对出生日期降序排列，对年级升序
     list_per_page = 10 # 分页,每页现实的数据数量,不设置默认每页显示20条数据
admin.site.register(Tag)
admin.site.register(Classification)
admin.site.register(Article,ArticleAdmin)
admin.site.register(Author)
admin.site.register(ImageUpload,ImageUploadAdmin)
admin.site.register(wxSmallProgram,wxSmallProgramAdmin)