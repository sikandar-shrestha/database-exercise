-- Q3) list all the databases 
show databases;

-- Q4) write the sql code necessary to use the albums_db database
-- show create database albums_db;
use albums_db;

-- Q5)show the currently selected database
select database();

-- Q6) list all tables in the database
show tables;

-- Q7) write the sql code to switch to the employees database
use employees;

-- Q8) show the currently selected dababase
show create database employees;

-- Q9) list all tables in the database
show tables;

-- Q10) explore the employees table. what different data types are present in this table 
describe employees;
-- Ans: int, date, varchar(14), varchar(16), enum('M','F')

-- Q11) which table(s) do you think contain a numeric type column? ( write this question and your answer in a comment)
describe departments; -- it doesnt have a numeric type column
describe dept_emp; -- it has 
describe dept_manager; -- it has
describe employees; -- it has
describe salaries; -- it has
describe titles; -- it has




-- Q12 which table(s) do you think contain a string type column? ( write this question and your answer in a comment)
describe departments; -- it  has a string type column
describe dept_emp; -- it has 
describe dept_manager; -- it has
describe employees; -- it has
describe salaries; -- it doesnt have
describe titles; -- it has


-- Q13 which table(s) do you think contain a date type column? ( write this question and your answer in a comment)
describe departments; -- it doesnt have
describe dept_emp; -- it has 
describe dept_manager; -- it has
describe employees; -- it has
describe salaries; -- it has
describe titles; -- it has

-- Q14) What is the relationship between the employees and the departments tables? (Write this question and your answer in a comment)
-- Ans:- Both have primary key but they dont have any common column
--       there is no similar columns between the two, but we know that
--      employees should be linked to a department somehow 

describe dept_emp;
-- this has a composite key that will combine our
-- employees and departments tables together

  


-- Q15) Show the SQL code that created the dept_manager table. Write the SQL it takes to show this as your exercise solution.

show create table dept_manager;

-- CREATE TABLE `dept_manager` (
--  `emp_no` int NOT NULL,
--  `dept_no` char(4) NOT NULL,
--  `from_date` date NOT NULL,
--  `to_date` date NOT NULL,
--  PRIMARY KEY (`emp_no`,`dept_no`),
--  KEY `dept_no` (`dept_no`),
--  CONSTRAINT `dept_manager_ibfk_1` FOREIGN KEY (`emp_no`) REFERENCES `employees` (`emp_no`) ON DELETE CASCADE ON UPDATE RESTRICT,
--  CONSTRAINT `dept_manager_ibfk_2` FOREIGN KEY (`dept_no`) REFERENCES `departments` (`dept_no`) ON DELETE CASCADE ON UPDATE RESTRICT
-- ) ENGINE=InnoDB DEFAULT CHARSET=latin1






