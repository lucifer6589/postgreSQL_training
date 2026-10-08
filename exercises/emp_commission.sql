postgres=# CREATE DATABASE emp_comm_db;
CREATE DATABASE
postgres=# \c emp_comm_db;
You are now connected to database "emp_comm_db" as user "postgres".
emp_comm_db=#

CREATE TABLE departments(
id INT PRIMARY KEY,
name VARCHAR(50) NOT NULL UNIQUE  
);

CREATE TABLE employees (
id INT PRIMARY KEY,
name VARCHAR(50) NOT NULL,
salary NUMERIC(12,2),
department_id INT NOT NULL,
CONSTRAINT fk_employee_department 
FOREIGN KEY (department_id) REFERENCES departments(id)
);

CREATE TABLE commissions(
id INT PRIMARY KEY,
employee_id  INT NOT NULL,
commission_amount NUMERIC(12,2) NOT NULL,
CONSTRAINT fk_commission_employee 
FOREIGN KEY (employee_id) 
REFERENCES employees(id)
);


CREATE INDEX idx_employees_department_id
ON employees(department_id);

CREATE INDEX idx_commissions_employee_id
ON commissions(employee_id);



emp_comm_db=# -- emp with highest total commission
emp_comm_db=# Select employee_id, SUM(commission_amount) AS total_commission
emp_comm_db-# FROM commissions
emp_comm_db-# GROUP BY employee_id
emp_comm_db-# ORDER BY total_commission DESC
emp_comm_db-# LIMIT 1;
 employee_id | total_commission
-------------+------------------
           1 |          9000.00
(1 row)


emp_comm_db=#
emp_comm_db=#
emp_comm_db=# -- emp with 4th highest salary
emp_comm_db=# SELECT id, name, salary
emp_comm_db-# FROM EMPLOYEES
emp_comm_db-# ORDER BY salary DESC
emp_comm_db-# OFFSET 3
emp_comm_db-# LIMIT 1;
 id |     name     |  salary
----+--------------+-----------
  3 | Rahul Dravid | 700000.00
(1 row)


emp_comm_db=#
emp_comm_db=# -- dept with highest commission
emp_comm_db=# SELECT e.department_id, SUM(c.commission_amount) AS highest_commision
emp_comm_db-# FROM employees e
emp_comm_db-# JOIN commissions c
emp_comm_db-# ON e.id = c.employee_id
emp_comm_db-# GROUP BY e.department_id
emp_comm_db-# ORDER BY highest_commision DESC
emp_comm_db-# LIMIT 1;
 department_id | highest_commision
---------------+-------------------
             1 |          13000.00
(1 row)


emp_comm_db=#
emp_comm_db=# -- employess getting commissoin > 3000
emp_comm_db=# SELECT STRING_AGG(e.name, ', ') AS employee_names,
emp_comm_db-# c.commission_amount
emp_comm_db-# FROM employees e
emp_comm_db-# JOIN commissions c
emp_comm_db-# ON e.id = c.employee_id
emp_comm_db-# WHERE c.commission_amount > 3000
emp_comm_db-# GROUP BY c.commission_amount
emp_comm_db-# ORDER BY c.commission_amount DESC;
      employee_names       | commission_amount
---------------------------+-------------------
 Chris Gayle, Wasim Akram  |           5000.00
 Chris Gayle, Rahul Dravid |           4000.00
(2 rows)