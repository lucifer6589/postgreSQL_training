sql_practice=# -- places where Jones can eat (nested query)
sql_practice=# SELECT location
sql_practice-# FROM sandwiches
sql_practice-# WHERE filling IN (
sql_practice(# SELECT filling
sql_practice(# FROM tastes
sql_practice(# WHERE name = 'Jones'
sql_practice(# );
 location
-----------
 O'Neill's
 Buttery
(2 rows)


sql_practice=#
sql_practice=# -- places where Jones can eat
sql_practice=# SELECT location
sql_practice-# FROM tastes t
sql_practice-# JOIN sandwiches s
sql_practice-# ON t.filling = s.filling
sql_practice-# WHERE name = 'Jones';
 location
-----------
 O'Neill's
 Buttery
(2 rows)


sql_practice=#
sql_practice=# -- for each location the number of poeple who can eat there
sql_practice=# SELECT location, COUNT(DISTINCT name) as num_of_people
sql_practice-# FROM tastes t
sql_practice-# JOIN sandwiches s
sql_practice-# ON t.filling = s.filling
sql_practice-# GROUP BY location;
 location  | num_of_people
-----------+---------------
 Buttery   |             3
 Lincoln   |             2
 O'Neill's |             3
 Old Nag   |             2
(4 rows)

