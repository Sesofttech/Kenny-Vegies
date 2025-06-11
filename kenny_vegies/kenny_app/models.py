from django.db import models

# Create your models here.

# Users table
class UsersReg(models.Model):
    name=models.CharField(max_length=100)
    email=models.EmailField()
    username=models.CharField(max_length=30)
    phone=models.IntegerField()
    dob=models.DateField()
    gender=models.CharField(max_length=20)
    password=models.CharField(max_length=100)

# Address Table
class UserAddress(models.Model):
    email=models.EmailField()
    region=models.CharField(max_length=50)
    town=models.CharField(max_length=70)
    postal_address=models.CharField(max_length=50)
    postal_code=models.IntegerField()
    
# Products table
class Products(models.Model):
    id=models.CharField(max_length=30,primary_key=True)
    name=models.CharField(max_length=100)
    description=models.TextField()
    color=models.CharField(max_length=50)
    state=models.CharField(max_length=20)

# Price Tables
class MfgPrice(models.Model):
    id=models.CharField(max_length=30, primary_key=True)
    price=models.FloatField()
    date=models.DateTimeField()

