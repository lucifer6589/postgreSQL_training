-- 1. explain fields
/* 
scans -> scan method used eg : seq, index , index only , bitmap index,
cost -> estimated planner cost 
rows -> estimated rows that are to be returned
width -> estimated avg size of rows
loops -> number of times the plan node executed 
filter -> condition applied to rows 
*/



-- 2. 
/*  
-- 2.1 
in postgreSQL , rows shows how many rows are expected to be returned 
if select returns the exact number of rows as predicted then the planner is right .

-- 2.2
if the rows returned and rows in explain query are not same, then we can consider
creating a index on the column and evaluate again using explain .
*/



-- 3
/*
SELECT * FROM comments WHERE commentable_id = 1 AND commentable_type = 'Article' AND user_id = 1;
if we are using this query a lot then :
we can create a composite index using all three columns 
since the order matters in composite indexes , we can choose as :
1.user_id -> to get all the comments of one uses seperately as well
2.commentable_type 
3.commentable_id
therefore :
index on (user_id, commentable_type, commentable_id)
*/



-- 4
EXPLAIN
SELECT DISTINCT c.customer_id
FROM customers c
JOIN orders o
ON o.customer_id = c.customer_id;

"HashAggregate  (cost=37.51..40.51 rows=300 width=4)"
"  Group Key: c.customer_id"
"  ->  Hash Join  (cost=16.75..35.74 rows=710 width=4)"
"        Hash Cond: (o.customer_id = c.customer_id)"
"        ->  Seq Scan on orders o  (cost=0.00..17.10 rows=710 width=4)"
"        ->  Hash  (cost=13.00..13.00 rows=300 width=4)"
"              ->  Seq Scan on customers c  (cost=0.00..13.00 rows=300 width=4)"
/*
seq scan -> to read table 
Hash cond -> condition to match rows
hash join -> combine matching rows
HashAggregate -> remove duplicate
*/

-- sub query 
EXPLAIN
SELECT c.customer_id
FROM customers c
WHERE c.customer_id IN (
    SELECT o.customer_id
    FROM orders o
);

"Hash Join  (cost=23.38..38.83 rows=150 width=4)"
"  Hash Cond: (c.customer_id = o.customer_id)"
"  ->  Seq Scan on customers c  (cost=0.00..13.00 rows=300 width=4)"
"  ->  Hash  (cost=20.88..20.88 rows=200 width=4)"
"        ->  HashAggregate  (cost=18.88..20.88 rows=200 width=4)"
"              Group Key: o.customer_id"
"              ->  Seq Scan on orders o  (cost=0.00..17.10 rows=710 width=4)"

-- in this case, subquery seems to work better according to Cost given by planner . 
-- although, it depends on a lot of factors like indexes, table size, groups , ordering , etc