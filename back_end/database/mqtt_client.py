import threading
import time
import listener1
import listener2
import publisher
t1=threading.Thread(target=listener1.runlistener1)
t2=threading.Thread(target=listener2.runlistener2)
t3 = threading.Thread(target=publisher.publisher)
t1.start()
t2.start()
t3.start()
