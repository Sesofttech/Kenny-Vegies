from django.urls import path
from . import views

# List of urls patterns
urlpatterns=[
    path('',views.index,name='home'),
    path('contact', views.contact_page, name="contact"),
    path('contact/success', views.message_success, name="message_success")
]