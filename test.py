import sqlite3

con = sqlite3.connect("test.db")

cur = con.cursor()

cur.execute("create table movie(title, year, score)")

cur.execute(
    """
    insert into movie(title, year, score) values 
    ('test1', 1111, 1.1),
    ('test2', 1112, 1.2)
    """)
con.commit()

data = [
    ('test3', 1113, 1.3),
    ('test4', 1114, 1.4),
    ('test5', 1115, 1.5),
]

cur.executemany("insert into movie values (?, ?, ?)", data)
con.commit()

for row in cur.execute("select * from movie order by year"):
    print(row)

con.close()

new_con = sqlite3.connect("test.db")
new_cur = new_con.cursor()

res = new_cur.execute("select title, year, score from movie order by score desc")
list_results = res.fetchall()

for item in list_results:
    print(item)