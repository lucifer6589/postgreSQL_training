CREATE DATABASE bank;

CREATE TABLE users(
id INT PRIMARY KEY,
name VARCHAR(50) NOT NULL,
email VARCHAR(100) UNIQUE NOT NULL,
account_no VARCHAR(20) UNIQUE NOT NULL
);

CREATE TABLE accounts(
id INT PRIMARY KEY,
account_no VARCHAR(20) UNIQUE NOT NULL,
balance NUMERIC(12,2) NOT NULL
);

ALTER TABLE accounts
ADD CONSTRAINT fk_accounts_users 
FOREIGN KEY (account_no) REFERENCES users(account_no);


postgres=# \c bank;
You are now connected to database "bank" as user "postgres".
bank=#
bank=# -- deposit 1000 rupees
bank=# BEGIN;
BEGIN
bank=*# UPDATE accounts
bank-*# SET balance = balance + 1000
bank-*# WHERE account_no = '1001';
UPDATE 1
bank=*# COMMIT;
COMMIT
bank=# SELECT * FROM accounts;
 id | account_no | balance
----+------------+---------
  2 | 1002       | 3200.00
  1 | 1001       | 6300.00
(2 rows)


bank=#
bank=# -- withdraw 500 rupees
bank=# BEGIN;
BEGIN
bank=*# UPDATE accounts
bank-*# SET balance = balance - 500
bank-*# WHERE account_no = '1001';
UPDATE 1
bank=*# COMMIT;
COMMIT
bank=# SELECT * FROM accounts;
 id | account_no | balance
----+------------+---------
  2 | 1002       | 3200.00
  1 | 1001       | 5800.00
(2 rows)


bank=#
bank=# -- A to B 200 rupees
bank=# BEGIN ;
BEGIN
bank=*# UPDATE accounts
bank-*# SET balance = balance + 200
bank-*# WHERE account_no = '1002';
UPDATE 1
bank=*#
bank=*# UPDATE accounts
bank-*# SET balance = balance - 200
bank-*# WHERE account_no = '1001';
UPDATE 1
bank=*# COMMIT;
COMMIT
bank=# SELECT * FROM accounts;
 id | account_no | balance
----+------------+---------
  2 | 1002       | 3400.00
  1 | 1001       | 5600.00
(2 rows)