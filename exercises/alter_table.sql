CREATE TABLE testing_table(
name VARCHAR NOT NULL,
contact_name VARCHAR,
roll_no VARCHAR PRIMARY KEY
);
SELECT * FROM testing_table;

ALTER TABLE testing_table
DROP COLUMN name;
SELECT * FROM testing_table;

ALTER TABLE testing_table 
RENAME COLUMN contact_name TO username;
SELECT * FROM testing_table;

ALTER TABLE testing_table
ADD COLUMN first_name VARCHAR,
ADD COLUMN last_name VARCHAR;
SELECT * FROM testing_table;

ALTER TABLE testing_table
ALTER COLUMN roll_no TYPE INTEGER
USING roll_no::INTEGER;
SELECT * FROM testing_table;