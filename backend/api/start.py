from flask import Flask
from flask import request
import json
import requests

# ENVIRONMENT
env = "PROD"

# app
app = Flask(__name__)

# configuration imports
if env == "PROD":
    from api.config.datacollector import DataCollector
    from api.config.dbqueries import DBQueries
else:
    from config.datacollector import DataCollector
    from config.dbqueries import DBQueries


@app.route("/")
def home():
    return "home route"


@app.route("/importData", methods=["POST"])
def importData():
    try:
        if request.method == "POST":
            status = {}
            reqBody = request.json
            if reqBody:
                print(reqBody)
                # Import Data
                masterData = DataCollector().importData(reqBody)
                status["message"] = "Data imported successfully"
                # Store Data in book_master
                try:
                    DBQueries().storeBookData(masterData)
                    status["message"] += " and Data stored successfully"
                except Exception as e:
                    status["message"] = "Error storing book data"
                status["data"] = masterData
                status["count"] = len(masterData)
            else:
                status["message"] = "missing required parameters"
            print(status)
            return status, 200, {"message": "Success"}
        else:
            raise Exception("Unsupported method")
    except Exception as e:
        message = {}
        message["error"] = e
        return json.dumps(message)


@app.route("/user/verify", methods=["POST"])
def user():
    try:
        if request.method == "POST":
            status = {}
            reqBody = request.json
            if reqBody:
                print(reqBody)
                state, users = DBQueries().verifyuser(reqBody)
                status["users"] = users
                status["state"] = state
            else:
                status["message"] = "missing required parameters"
            print(status)
            return status, 200, {"message": "Success"}
        
    except Exception as e:
        message = {}
        message["error"] = e
        return json.dumps(message)


@app.route("/search/data", methods=["POST"])
def getData():
    try:
        if request.method == "POST":
            status = {}
            reqBody = request.json
            if reqBody is None:
                print(reqBody)
                reqBody = {"title": ""}
                masterData = DBQueries().getDbData(reqBody)
                status["message"] = "Success"
                status["data"] = masterData
                status["count"] = len(masterData)
            else:
                masterData = DBQueries().getDbData(reqBody)
                status["message"] = "Success"
                status["data"] = masterData
                status["count"] = len(masterData)
            print(status)
            return status, 200, {"message": "Success"}
        else:
            raise Exception("Invalid request")
    except Exception as e:
        message = {}
        message["error"] = e
        return json.dumps(message)


@app.route("/members/all", methods=["POST"])
def getmembers():
    try:
        status = {}
        masterData = DBQueries().getmembers()
        status["message"] = "success"
        status["data"] = masterData
        status["count"] = len(masterData)
        print(status)
        return status, 200, {"message": "success"}
    
    except Exception as e:
        message = {}
        message["error"] = e
        return json.dumps(message)


@app.route("/isbookavailable", methods=["POST"])
def isbookavailable():
    try:
        if request.method == "POST":
            status = {}
            reqBody = request.json
            if reqBody:
                print(reqBody)
                state = DBQueries().bookisavailable(reqBody)
                status["available"] = state
            else:
                status["message"] = "reqBody Missing"
            print(status)
            return status, 200, {"message": "Success"}
        else:
            raise Exception("Invalid request")
    except Exception as e:
        message = {}
        message["error"] = e
        return json.dumps(message)


@app.route("/addbook", methods=["POST"])
def addbook():
    try:
        if request.method == "POST":
            status = {}
            reqBody = request.json
            if reqBody:
                print(reqBody)
                DBQueries().addBooks(reqBody)
                status["message"] = "data added successfully"
            else:
                status["message"] = "reqBody Missing"
            print(status)
            return status, 200, {"message": "Success"}
        else:
            raise Exception("Invalid request")
    except Exception as e:
        message = {}
        message["error"] = e
        return json.dumps(message)


@app.route("/addmembers", methods=["POST"])
def addmembers():
    try:
        if request.method == "POST":
            status = {}
            reqBody = request.json
            if reqBody:
                print(reqBody)
                DBQueries().addmembers(reqBody)
                status["message"] = "Member added successfully"
            else:
                status["message"] = "reqBody Missing"
            print(status)
            return status, 200, {"message": "Success"}
        else:
            raise Exception("Invalid request")
    except Exception as e:
        message = {}
        message["error"] = e
        return json.dumps(message)


# NOTE: This route should only be used when /isbookavailable return True otherwise it would break the application
@app.route("/issuebook", methods=["POST"])
def issuebook():
    try:
        if request.method == "POST":
            status = {}
            reqBody = request.json
            if reqBody:
                print(reqBody)
                # STEP 1 : recalculate its due_amt
                # STEP 2 : validate the due amount(i.e. <=500)
                # STEP 3 : issue book
                state = DBQueries().issue_book(reqBody)
                status["message"] = "Book Issued" if state else "Book cannot be issued, Dues may be over Rs.500"
            else:
                status["message"] = "reqBody Missing"
            print(status)
            return status, 200, {"message": "Success"}
        else:
            raise Exception("Invalid request")
    except Exception as e:
        message = {}
        message["error"] = e
        return json.dumps(message)


# NOTE: This route should only be used when /isbookavailable returns False
@app.route("/returnbook", methods=["POST"])
def returnbook():
    try:
        if request.method == "POST":
            status = {}
            reqBody = request.json
            if reqBody:
                print(reqBody)
                state = DBQueries().return_book(reqBody)
                status["message"] = (
                    "Book returned" if state else "Book cannot be returned"
                )
            else:
                status["message"] = "reqBody Missing"
            print(status)
            return status, 200, {"message": "Success"}
        else:
            raise Exception("Invalid request")
    except Exception as e:
        message = {}
        message["error"] = e
        return json.dumps(message)


@app.route("/bookdelete", methods=["POST"])
def deletebook():
    try:
        if request.method == "POST":
            status = {}
            reqBody = request.json
            if reqBody:
                print(reqBody)
                state = DBQueries().deleteBook(reqBody)
                status["message"] = "Delete Successful"
            else:
                status["message"] = "reqBody Missing"
            print(status)
            return status, 200, {"message": "Success"}
        else:
            raise Exception("Invalid request")
    except Exception as e:
        message = {}
        message["error"] = e
        return json.dumps(message)


@app.route("/memberdelete", methods=["POST"])
def deletemember():
    try:
        if request.method == "POST":
            status = {}
            reqBody = request.json
            if reqBody:
                print(reqBody)
                state = DBQueries().deleteMem(reqBody)
                status["message"] = "Delete Successful" if state else "Failed"
            else:
                status["message"] = "reqBody Missing"
            print(status)
            return status, 200, {"message": "Success"}
        else:
            raise Exception("Invalid request")
    except Exception as e:
        message = {}
        message["error"] = e
        return json.dumps(message)


if __name__ == "__main__":
    app.run(debug=True)
