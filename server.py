import requests
from flask import Flask, request

app = Flask(__name__)

@app.route("/fetch")
def fetch():
    url = request.args.get("url")
    r = requests.get(url)
    return r.text
