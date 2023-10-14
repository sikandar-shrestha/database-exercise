-- Exercises

-- Create a file named where_advanced_exercises.sql. Use the employees database.
show databases;
use employees;
select database();
show tables;

-- Q1) Find all current or previous employees with first names 'Irena', 'Vidya', or 'Maya' using IN. 
--     What is the employee number of the top three results?
describe employees;
select * from employees;

select *
from employees
where first_name in ('Irena','Vidya', 'Maya') ;
-- top three results of emp_no are 10200, 10397, and 10610

-- Q2) Find all current or previous employees with first names 'Irena', 'Vidya', or 'Maya', as in Q2, but use OR instead of IN. 
--     What is the employee number of the top three results? Does it match the previous question?
select * from employees 
where first_name ='Irena' or first_name='Vidya' or  first_name='Maya';

-- A: 10200, 10397, 10610
-- A: it's the same output as Q1




-- Q3) Find all current or previous employees with first names 'Irena', 'Vidya', or 'Maya', using OR, and who is male. 
--     What is the employee number of the top three results?
select emp_no, first_name
from employees
where first_name='Irena' or first_name= 'Vidya' or first_name= 'Maya'
and gender='M';

-- A: 10200, 10397, 10610 emp_no





-- Q4) Find all unique last names that start with 'E'.

select distinct last_name 
from employees
where last_name like 'E%';

-- Q5) Find all unique last names that start or end with 'E'.
select distinct last_name 
from employees
where last_name like 'E%'
or last_name like '%E';


-- Q6) Find all unique last names that end with E, but does not start with E?

select distinct last_name 
from employees
where last_name like '%E' and last_name not like 'E%';


-- Q7) Find all unique last names that start and end with 'E'.

select distinct last_name 
from employees
where last_name like 'E%E';

-- Q8) Find all current or previous employees hired in the 90s. Enter a comment with the top three employee numbers.

select *
from employees
where hire_date like '199%';
-- where hire_date BETWEEN 19900101 AND 19991225
-- WHERE hire_date BKETWEEN '1990-01-01' AND '1999-12-31'
-- WHERE year(hir_date) BETWEEN 1990 AND 1999




-- A: 10008, 10011, 10012


-- Q9) Find all current or previous employees born on Christmas. Enter a comment with the top three employee numbers.

select *
from employees
where birth_date like '%-12-25'
;

-- A: 10078, 10115, 10261

-- Q10) Find all current or previous employees hired in the 90s and born on Christmas. Enter a comment with the top three employee numbers.

select *
from employees
where hire_date like '199%' and birth_date like '%-12-25';

-- A: 10261, 10438, 10681

-- Q11) Find all unique last names that have a 'q' in their last name.

select distinct last_name 
from employees
where last_name like '%q%';

-- Q12) Find all unique last names that have a 'q' in their last name but not 'qu'.

select distinct last_name 
from employees
where last_name like '%q%' and last_name not like '%qu%';
