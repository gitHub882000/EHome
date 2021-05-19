# EHome
An Android Application to manage devices at home <br />
There is also backend for ehome

# BACKEND HOW TO USE API
get value from adafruit: send GET request to http://localhost:5000/listener/<username>/test1  <br />
=> the value return is the current state of the the device on ADAFRUIT server <br />

post value to adafruit: send GET request to http://localhost:5000/publisher/<username>  <br />
with the content of the http pakage like this: <br />
{
    "name":"test1",
    "value":"OFF"
}
=> the feed named "test1" will turn off on ADAFRUIT server 
  
# Some useful document
 Vietnamese: https://techmaster.vn/posts/33693/ky-thuat-long-polling-websockets-server-sent-events-comet
