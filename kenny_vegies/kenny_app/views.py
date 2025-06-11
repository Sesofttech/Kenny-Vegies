from django.http import HttpResponse
from django.shortcuts import render, redirect
from .forms import ContactUsForm, UserRegistration, UserLogin


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
    return render(request, 'success/contact_us.html',context)

# Sent Message Success
def message_success(request):
    return render(request, 'success/message_success.html')

# User Signup
def sign_up(request):
    if request.method=="POST":
        form = UserRegistration(request.POST)
        if form.is_valid():
            return redirect('user_registered_successfully')
    else:
        form=UserRegistration()

    context={'form':form}
    return render(request, 'users/signup.html',context)

# User Login
def login(request):
    if request.method=="POST":
       login=UserLogin(request.POST)
       if login.is_valid():
           return redirect('login-success')
    else:
       login=UserLogin()

    context={'form':login}
    return render(request,'users/login.html',context)

# Login Success
def login_success(request):
    return render(request, 'success/login-success.html')

# User Registered Successfully
def registered_successfully(response):
    return render(response, 'success/user_success.html')