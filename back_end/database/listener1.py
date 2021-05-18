from Adafruit_IO import MQTTClient, Feed
import sys
import time
import random
ADAFRUIT_IO_USERNAME = 'Drakies3172'
ADAFRUIT_IO_KEY = 'aio_ntwl37DmkzVAn7QV3P70uawZMLPk'
FEED_ID1 = 'test1'
FEED_ID2 = 'test2'
topics = [FEED_ID1,FEED_ID2]
# Define callback functions which will be called when certain events happen.
def connected(client):
    # Connected function will be called when the client is connected to Adafruit IO.
    # This is a good place to subscribe to feed changes.  The client parameter
    # passed to this function is the Adafruit IO MQTT client so you can make
    # calls against it easily.
    # Subscribe to changes on a feed named DemoFeed.
    for feed in topics:
        client.subscribe(feed)


def subscribe(client, userdata, mid, granted_qos):
    # This method is called when the client subscribes to a new feed.
    print('Subscribed to {0} with QoS {1}'.format(topics[mid-1], granted_qos[0]))


def disconnected(client):
    # Disconnected function will be called when the client disconnects.
    sys.exit(1)


def message(client, feed_id, payload):
    # Message function will be called when a subscribed feed has a new value.
    # The feed_id parameter identifies the feed, and the payload parameter has
    # the new value.
    # getValue(payload)
    print(feed_id,payload)


# Start a message loop that blocks forever waiting for MQTT messages to be
# received.  Note there are other options for running the event loop like doing
# so in a background thread--see the mqtt_client.py example to learn more.
def runlistener1():
    # Create an MQTT client instance.
    client = MQTTClient(ADAFRUIT_IO_USERNAME, ADAFRUIT_IO_KEY)

    # Setup the callback functions defined above.
    client.on_connect = connected
    client.on_disconnect = disconnected
    client.on_message = message
    client.on_subscribe = subscribe

    # Connect to the Adafruit IO server.
    client.connect()
    while(True):
        client.loop_background()
        time.sleep(0.1)


runlistener1()