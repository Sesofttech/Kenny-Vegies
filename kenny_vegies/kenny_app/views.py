from django.shortcuts import render, redirect
from .forms import ContactUsForm


# Create your views here.

def index(response):
    return render(response, 'home_page/index.html')

# View to handle the contact form
def contact_page(request):
    if request.method=="POST":
        form=ContactUsForm(request.POST)
        if form.is_valid():
            form.send_message()
            return redirect('message_success')
    else:
        form = ContactUsForm()
    context = {'form':form}
    return render(request, 'success/message_success.html')

# Sent Message Success
def message_success(request):
    return render(request, 'success/message_success.html')

# User Signup
def sign_up(request):
    pass

# User Login
def login(request):
    pass