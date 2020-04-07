from django.contrib import admin
from .models import Criteria
from .models import Criterium
from .models import Patient
from .models import CDAFile

admin.site.register(Criteria)
admin.site.register(Criterium)
admin.site.register(Patient)
admin.site.register(CDAFile)
