import paho.mqtt.publish as publish
ADAFRUIT_IO_USERNAME = "Drakies3172"
ADAFRUIT_IO_KEY = "aio_ntwl37DmkzVAn7QV3P70uawZMLPk"
def publish_ada(feed_id,payload):
    publish.single('Drakies3172/feeds/{}'.format(feed_id),hostname="io.adafruit.com",
    auth={"username":ADAFRUIT_IO_USERNAME, "password":ADAFRUIT_IO_KEY},payload = payload)