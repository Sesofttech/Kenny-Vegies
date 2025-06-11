from django.urls import path
from . import views

# List of urls patterns
urlpatterns=[
    path('',views.index,name='home'),
    path('contact', views.contact_page, name="contact"),
    path('contact/success', views.message_success, name="message_success"),
    path('signup', views.sign_up, name='signup'),
    path('login', views.login, name='login'),
    path('login/success', views.login_success, name='login-success'),
    path('register/success', views.registered_successfully, name='user_registered_successfully')
]