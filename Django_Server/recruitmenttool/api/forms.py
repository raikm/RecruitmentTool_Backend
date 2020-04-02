from django.forms import ClearableFileInput
from .models import InformationRequest
from .models import InformationRequest


class FeedModelForm(forms.ModelForm):
    class Meta:
        model = InformationRequest
        fields = ['text']

class FileModelForm(forms.ModelForm):
    class Meta:
        model = UploadFragment
        fields = ['file']
        widgets = {
            'file': ClearableFileInput(attrs={'multiple': True}),
        }
