import threading
import time

def run():
    k = 0
    while(True):
        print('jump')
        k+=100
        time.sleep(0.1)
def jump():
    k = 0
    while(True):
        print('run')
        k+=100
        time.sleep(0.1)
t=threading.Thread(target=run)
t1=threading.Thread(target=jump)
t.start()
t1.start()