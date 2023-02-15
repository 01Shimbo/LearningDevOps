from django.shortcuts import render
from .models import ticket

# questions = [
#     {
#         'name': 'Shane Duke',
#         'date': '2022-12-31 06:19:47',
#         'age': 22,
#         'problem': 'Smart Phone',
#         'note': 'note 1',
#     },
#     {
#         'name': 'Shane Duke',
#         'date': '2022-13-31 07:22:58',
#         'age': 22,
#         'problem': 'Tv',
#         'note': 'note 2',
#     }
# ]


def home(request):
    # questions = PostForm()
    context = {
        'tickets': ticket.objects.all()
    }
    return render(request, 'form/home.html', context)


def new(request):
    # new = ticket(request.Post)
    return render(request, 'form/new.html', {'title': 'New Ticet'})
    # return render(request, 'form/new.html', {'title': 'New Ticet'}, {'new': new})


def about(request):
    return render(request, 'form/about.html', {'title': 'About'})
