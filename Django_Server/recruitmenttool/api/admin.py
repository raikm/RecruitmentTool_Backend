from django.contrib import admin
from .models import Study
from .models import Criterion
from .models import Condition
#from .models import Patient
#from .models import CDAFile

admin.site.register(Study)
admin.site.register(Criterion)
admin.site.register(Condition)
#admin.site.register(Patient)
#admin.site.register(CDAFile)
