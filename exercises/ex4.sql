
-- backup
C:\Program Files\PostgreSQL\18\bin>pg_dump -U postgres -d sql_practice -F c -f "D:\downloads D\sql_back.backup"
Password:

-- restore
C:\Program Files\PostgreSQL\18\bin>pg_restore -U postgres -d sql_practice_restored "D:\downloads D\sql_back.backup"
Password:

postgres=# \c sql_practice_restored
You are now connected to database "sql_practice_restored" as user "postgres".
sql_practice_restored=# \dt
                 List of tables
 Schema |        Name        | Type  |  Owner
--------+--------------------+-------+----------
 public | article_categories | table | postgres
 public | articles           | table | postgres
 public | branch             | table | postgres
 public | comments           | table | postgres
 public | customers          | table | postgres
 public | departments        | table | postgres
 public | employees          | table | postgres
 public | holdings           | table | postgres
 public | locations          | table | postgres
 public | order_items        | table | postgres
 public | orders             | table | postgres
 public | products           | table | postgres
 public | sandwiches         | table | postgres
 public | tastes             | table | postgres
 public | titles             | table | postgres
 public | users              | table | postgres
(16 rows)


sql_practice_restored=# \du
                               List of roles
  Role name   |                         Attributes
--------------+------------------------------------------------------------
 postgres     | Superuser, Create role, Create DB, Replication, Bypass RLS
 sql_readonly |
 vtapp_user   |

