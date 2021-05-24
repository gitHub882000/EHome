from flask import Flask,request,jsonify
from database import dbapi,publisher
app = Flask(__name__)
@app.route('/listener/<string:user_name>/<string:feed_name>')
def displayListener(user_name,feed_name):
    rs = dbapi.getFeedValue(feed_name)
    return rs
@app.route('/publisher/<string:user_name>',methods = ['POST'] )
def test1pub(user_name):
    data = request.json
    publisher.publish_ada(data["name"],data["value"])
    return jsonify(data)

@app.route('/')
def home():
    return "Backend of Ehome"
if __name__ == "__main__":
    app.run(debug=True)