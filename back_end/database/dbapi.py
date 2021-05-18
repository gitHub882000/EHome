import sqlite3
import os 

dir_path = os.path.dirname(os.path.realpath(__file__))
realpath = dir_path.__add__('\example.db')
def getaAllFeeds(): 
    con = sqlite3.connect(realpath)
    cur = con.cursor()
    ls = []
    for k in cur.execute('''SElect feed_id from feed_information'''):
        ls.append(k[0])
    con.close()
    return ls
def updateFeeds(feed_id,value):
    con = sqlite3.connect(realpath)
    cur = con.cursor()
    ls = []
    cur.execute('''UPDATE feed_information
                        SET  value= '{}'
                        WHERE feed_id = '{}'; '''.format(value,feed_id))
    con.commit()
    con.close()
    return 0
def getFeedValue(feed_id):
    con = sqlite3.connect(realpath)
    cur = con.cursor()
    ls = []
    record =  cur.execute(''' SElect value from feed_information WHERE feed_id ='{}' '''.format(feed_id))
    rs = ''
    try:
        rs = record.fetchall()[0][0]
    except: IndexError
    if len(rs) > 0:
        return rs
    return -1

print(getFeedValue('test1'))