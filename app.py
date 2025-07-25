# app.py
from flask import Flask

app = Flask(__name__)

@app.route('/')
def home():
    return "Bienvenue sur le serveur Flask !"

@app.route('/status')
def status():
    return {"status": "OK", "service": "Flask"}

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
