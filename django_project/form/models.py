from django.db import models
from django.utils import timezone
from django.contrib.auth.models import User

# check if migration  is configured: python3 manage.py showmigrations
# if no migrations run python3 manage.py makemigrations then migrate
# if not class in showmigrations put directory in settings.py > INSTALLED_APPS


class ticket(models.Model):
    problem_choices = (
        ('Tv', 'Tv'),
        ('Internet', 'Internet'),
        ('Smart Phone', 'Smart Phone')
    )
    name = models.ForeignKey(User, on_delete=models.CASCADE)
    date = models.DateTimeField(default=timezone.now)
    age = models.IntegerField()
    problem = models.CharField(max_length=20, choices=problem_choices)
    note = models.CharField(max_length=250)

    # def __str__(self):
    #     return self.name
# Create your models here.
