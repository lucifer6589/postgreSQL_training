sql_practice=# -- places where Jones can eat (nested query)
sql_practice=# SELECT DISTINCT location
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
sql_practice=# SELECT DISTINCT location
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




-- ### second pdf 
sql_practice=# -- books publishes by macmillan
sql_practice=# SELECT title
sql_practice-# FROM titles
sql_practice-# WHERE publisher = 'Macmillan';
  title
----------
 Susannah
 The Wife
(2 rows)


sql_practice=#
sql_practice=# -- branch with ann brown books (nested)
sql_practice=# SELECT DISTINCT branch
sql_practice-# FROM holdings
sql_practice-# WHERE title IN (
sql_practice(# SELECT title
sql_practice(# FROM titles
sql_practice(# WHERE author = 'Ann Brown'
sql_practice(# );
 branch
--------
 B1
 B2
 B3
(3 rows)


sql_practice=#
sql_practice=#
sql_practice=# -- branch with ann brown books
sql_practice=# SELECT DISTINCT branch
sql_practice-# FROM holdings h
sql_practice-# JOIN titles t
sql_practice-# ON h.title = t.title
sql_practice-# WHERE author = 'Ann Brown';
 branch
--------
 B1
 B2
 B3
(3 rows)


sql_practice=#
sql_practice=#
sql_practice=# -- total number of books
sql_practice=# SELECT branch , SUM(copies)
sql_practice-# FROM holdings
sql_practice-# GROUP BY branch;
 branch | sum
--------+-----
 B3     |   9
 B1     |   6
 B2     |   9
(3 rows)
