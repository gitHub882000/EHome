import sqlite3
con = sqlite3.connect('example.db')
cur = con.cursor()
cur.execute('''CREATE TABLE if not exists feed_information(house_code,feed_id,value)''')
cur.execute("INSERT INTO feed_information VALUES ('Drakies3172','test1','ON')")
# cur.execute("INSERT INTO feed_information VALUES ('Drakies3172','test2','ON')")
# cur.execute("INSERT INTO feed_information VALUES ('Drakies3172','test3','ON')")
# cur.execute("INSERT INTO feed_information VALUES ('Drakies3172','test4','ON')")
# cur.execute("INSERT INTO feed_information VALUES ('Drakies3172','test5','ON')")

for k in cur.execute('SELECT * from feed_information'):
  print(k)
con.commit()
con.close()