from django.contrib import admin
#from .models import InformationRequest
# Register your models here.

#admin.site.register(InformationRequest)
from .models import InformationRequest, UploadFragment

class FeedFileInline(admin.TabularInline):
    model = UploadFragment


class FeedAdmin(admin.ModelAdmin):
    inlines = [
        FeedFileInline,
    ]

admin.site.register(InformationRequest, FeedAdmin)
