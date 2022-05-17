#!/usr/bin/env python
# coding: utf-8

# In[2]:


#!/usr/bin/env python
# -*- coding: utf-8 -*-
from collections import defaultdict
import pymysql
from array import array
import pymysql
import flask

# prompt user to enter correct password and username and validate 
while True :
    try:
        username = input("Enter your username for mysql")
        pass_word = input("Enter your password for mysql ")
        
        # connecting database by represenating cnx varaiable as a part of the connection
        cnx = pymysql.connect(host='localhost', user=username, password=pass_word,
             db='lotrfinal_1',charset='utf8mb4',cursorclass=pymysql.cursors.DictCursor )
    except sql.err.OperationalError:
        print("Connection is not established . Enter correct username and password ")
    else:
        break
print("Connection is established ")  

# making the cursor 
cur = cnx.cursor()
stmt_select = "select character_name from lotr_character order by character_name"
cur.execute(stmt_select)
rows=cur.fetchall()
listofcharacters=[]

#generating list of valid characters names for user to select 
for row in rows:
    string = row["character_name"]
    print(string)
    listofcharacters.append(row["character_name"].casefold())


print("Please enter a name from one of the following values as show in the above list: ",listofcharacters,"\n")
# prompting the user to enter a character name and storing it in a variable
string=str(input("Enter a character name: ")) 

# validation if the character name exist in each row obtained from sql 
#displaying an error message and re-prompting the user to enter the character name again
while ((string.casefold() not in listofcharacters)):
    print("Error: You entered an invalid character name ") 
    print(string)
    print("Please enter a name from one of the following valid character : ",listofcharacters,"\n")
    string=str(input("Enter a character name: "))
print("Calling the procedure 'track_character'")
cur.close()
cur2=cnx.cursor()
mylist=[string]
print(mylist)
cur2.callproc('track_character',mylist)
for res in cur2.fetchall():
    print(res)
cur2.close()
#closing the database connnection 
cnx.close()





