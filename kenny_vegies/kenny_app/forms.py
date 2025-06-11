from django import forms

# Contact Us form
class ContactUsForm(forms.Form):
    name=forms.CharField(max_length=100)
    email=forms.EmailField()
    phone=forms.IntegerField()
    message=forms.CharField(widget=forms.Textarea)

    # Method for sending the message
    def send_message(self):
        print(f"Sending email from {self.cleaned_data['email' + 'phone']} and the message {self.cleaned_data['message']}")

# User Registration form
class UserRegistration(forms.Form):
    name=forms.CharField(max_length=100)
    email=forms.EmailField()
    username=forms.CharField(max_length=30)
    phone=forms.IntegerField(label='Phone Number')
    dob=forms.DateField(label='Date of Birth')
    gender=forms.ChoiceField(choices=[(' ', '----'),('F', 'Female'),('M', 'Male')],label="Gender", initial=' ')
    password=forms.CharField(label='Password', widget=forms.PasswordInput())
    repeat_password=forms.CharField(label='Repeat Password', widget=forms.PasswordInput())

# Login form
class UserLogin(forms.Form):
    username=forms.CharField(label='Username', max_length=70)
    password=forms.CharField(label='Password', widget=forms.PasswordInput())

