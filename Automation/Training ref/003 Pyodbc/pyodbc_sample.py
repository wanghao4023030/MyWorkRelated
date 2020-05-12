#-*- coding:utf-8 -*-
import pyodbc

db_connectString = "DRIVER={SQL Server}; SERVER=10.112.20.84\\GCPACSWS;DATABASE=wggc; UID=sa;PWD=sa20021224$"

# Define a database connect
conn = pyodbc.connect(db_connectString)
# Create a cursor to execute SQL statement
cursor = conn.cursor()
# Execute SQL statement
cursor.execute("select * from wggc.dbo.Users")

# Get one records.
row = cursor.fetchone()
print(row)
print('name:', row[2])          # access by column index (zero-based)
print('name:', row.UserName)   # access by name

# Get All records
rows = cursor.fetchall()
for row in rows:
    print("User Name: " + row.UserName, " User Role: " + row.UserRole)


#Try to delete some recors.
cursor.execute("delete from wggc.dbo.Users where UserID = 'test'")
print(cursor.rowcount, 'users deleted')
conn.commit()


# Try to insert a data to wggc.dbo.users
cursor.execute('''insert wggc.dbo.Users 
(UserID, UserName, [Password], FullName, LocalFullName, Department, Title, UserRole, IsFirstLogin, 
PwdNeverExpire, PwdLastModifyTime, Modality)
values
('test', 'test', '49CE5FB6D05148ACB66A', null, null, null, null, 'Administrator', 0, 1,
 '2018-12-26 16:01:01.920', null)''')
conn.commit()  # The records must commit, if not the records will not insert.


# Try to update a records
cursor.execute("update wggc.dbo.Users set UserName = 'newtest' where UserID = 'test'")
print(cursor.rowcount, 'users updated')
conn.commit()



# Try to execute a store procedure
cursor.execute("exec [dbo].[AFP_SP_GetFilmInfo] N'1.2.840.113564.86.3.0.26824.20190808093319.811.7756'")
rows = cursor.fetchall()
print(rows)

studyUID = '1.2.840.113564.86.3.0.26824.20190808093319.811.7756'
cursor.execute('''exec [dbo].[AFP_SP_GetFilmInfo] ?''', studyUID)
rows = cursor.fetchall()
print(rows)


cursor.execute('''
                SELECT UserName
                FROM WGGC.DBO.USERS
                WHERE UserID = ? 
                ''', 'Admin')
rows = cursor.fetchall()
print(rows)


cursor.execute('''
                SELECT UserName
                FROM WGGC.DBO.USERS
                WHERE UserID like ? 
                ''', '%Ad%')
rows = cursor.fetchall()
print(rows)
