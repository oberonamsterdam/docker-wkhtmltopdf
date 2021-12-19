New features:

* Updated to Ubuntu 20.04
* Updated WKHTMLTOPDF to 0.12.6-1
* Updated to Python3.8


## Build the image

`cd ubuntu20-python3`

`docker build -t wkhtmltopdf .`


## Run the container

`docker run -d -p 6500:6500 localhost/wkhtmltopdf`


## Python3 file example

``` python
import requests

with open('input_file.html', 'r') as f:
    html = f.read()

response = requests.post('http://127.0.0.1:6500/', files={'file': html})

with open('output_file.pdf', 'w+b') as f:
    f.write(response.content)
```


## Python3 json example

``` python
import json
import requests

html = """<!DOCTYPE html>
<html>
    <head>
        <title>Horay!</title>
    </head>	
    <body>
        <h1>Hello World!</h1>		
    </body>
</html>
"""

data = {
    'contents': html,
}
headers = {
    'Content-Type': 'application/json',  # This is important
}

response = requests.post('http://127.0.0.1:6500/', data=json.dumps(data), headers=headers)

with open('output_file.pdf', 'w+b') as f:
    f.write(response.content)
```
