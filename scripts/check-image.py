import os
import requests
from requests.auth import HTTPBasicAuth

address = os.getenv('DOCKER_REGISTRY_ADDRESS')
username = os.getenv('DOCKER_REGISTRY_USERNAME')
password = os.getenv('DOCKER_REGISTRY_PASSWORD')
image = os.getenv('DOCKER_REGISTRY_IMAGE_NAME')
tag = os.getenv('DOCKER_REGISTRY_IMAGE_TAG')

# Check if the credentials are available
if username is None or password is None:
    print("Error: Environment variables for username and/or password are not set.")
    exit(1)

url = f"https://{address}/v2/{image}/tags/list"
response = requests.get(url, auth=HTTPBasicAuth(username, password))

# Check if the request was successful
tags = []
if response.status_code == 200:
    tags = response.json()["tags"]

if tag in tags:
    print("true")
else:
    print("false")
