#-*- coding:utf-8 -*-
from datetime import datetime
import re
import time
import requests

#login the platform with user and password
json_data = {"loginname": "admin", "password": "123456"}
res = requests.post("http://10.112.20.84/Platform/", data=json_data)
print(res.json())
login_result = res.json().get('Message')

if login_result == "LoginSuccess":
    print("Login successfully.")
else:
    print("Login failed.")

# get the cookie and auto code from server response
cookies = res.headers.get('Set-Cookie')
auth_string = re.search(r'(?<=access_token%22%3A%22)[\s\S]*(?=%22%2C%22token_type)',cookies)
auth_string = auth_string.group()
print(cookies)
print(auth_string)

# Wait for 10 seconds
time.sleep(10)

# add the header information because our system will check the auth code and cookies
myheaders = {'Accept': 'text / html, application / xhtml + xml, application / xml;',
             'Authorization': 'bearer ' + auth_string, 'Cookie': cookies}

res = requests.get("http://10.112.20.84/Platform/Account/CheckLoginStatus", headers=myheaders)
print(res.text)

if res.text == "true":
    print("The user is logined")
else:
    print("The user have logout.")
