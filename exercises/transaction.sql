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


\c bank;
You are now connected to database "bank" as user "postgres".

-- deposit 1000 rupees
BEGIN;
BEGIN
UPDATE accounts
SET balance = balance + 1000
WHERE account_no = '1001';
-- update takes lock automatically, and no extra is needed for update here

COMMIT;
SELECT * FROM accounts;
id | account_no | balance
----+------------+---------
2 | 1002       | 3200.00
1 | 1001       | 6300.00
(2 rows)



-- withdraw 500 rupees
BEGIN;

SELECT balance 
FROM accounts 
WHERE account_no = '1001' 
FOR UPDATE; -- lock row

UPDATE accounts
SET balance = balance - 500
WHERE account_no = '1001';


COMMIT;
SELECT * FROM accounts;
id | account_no | balance
----+------------+---------
2 | 1002       | 3200.00
1 | 1001       | 5800.00
(2 rows)



-- A to B 200 rupees
BEGIN ;


SELECT account_no, balance 
FROM accounts 
WHERE account_no IN ('1001', '1002')
FOR UPDATE; --lock rows

UPDATE accounts
SET balance = balance + 200
WHERE account_no = '1002';

UPDATE accounts
SET balance = balance - 200
WHERE account_no = '1001';

COMMIT;

SELECT * FROM accounts;
id | account_no | balance
----+------------+---------
2 | 1002       | 3400.00
1 | 1001       | 5600.00
(2 rows)