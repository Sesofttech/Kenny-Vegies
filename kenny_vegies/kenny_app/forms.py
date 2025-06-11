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
    username=forms.CharField(max_length=70)
    phone=forms.IntegerField()
    dod=forms.DateField()
    password=forms.PasswordInput()
    repeat_password=forms.PasswordInput()

# Login form
class UserLogin(forms.Form):
    username=forms.CharField(max_length=70)
    password=forms.PasswordInput()

