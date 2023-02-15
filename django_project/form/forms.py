from django.forms import ModelForm
from .models import ticket

class PostForm(ModelForm):
    class Meta:
        model = ticket
        fields = '__all__'