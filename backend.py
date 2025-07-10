from flask import Flask, request

app = Flask(__name__)

user_balances = {"alice": 100}

@app.route("/transfer", methods=["POST"])
def transfer():
    recipient = request.form["to"]
    amount = int(request.form["amount"])
    user_balances["alice"] -= amount
    user_balances[recipient] = user_balances.get(recipient, 0) + amount
    return "Transfer complete"
