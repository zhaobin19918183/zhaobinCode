from django.contrib import admin
from  .models import Tag,Classification,Article,Author
# Register your models here.

admin.site.register(Tag)
admin.site.register(Classification)
admin.site.register(Article)
admin.site.register(Author)