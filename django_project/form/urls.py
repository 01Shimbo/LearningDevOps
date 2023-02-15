from django.urls import path
from . import views
from users import views as user_views

urlpatterns = [
    path('', views.home, name='form-home'),
    path('about/', views.about, name='form-about'),
    path('new/', views.new, name='form-new'),
    path('users/register/', user_views.register, name= 'users-register')
]