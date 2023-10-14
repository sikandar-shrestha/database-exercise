
-- Exercises

-- Exercise Goals

-- Use ORDER BY clauses to create more complex queries for our database
show databases;
use employees;
select database();
show tables;

-- Q1) Create a new file named order_by_exercises.sql and copy in the contents of your exercise from the previous lesson.

-- Q2) Find all employees with first names 'Irena', 'Vidya', or 'Maya', and order 
-- your results returned by first name. In your comments, answer: What was the first and last name in the first row of the results? 
-- What was the first and last name of the last person in the table? 

select *
from employees
where first_name in ('Irena','Vidya', 'Maya') 
order by first_name; 

-- A: 1st row = Irena,Reutenauer
-- A: last person = Vidya, Simmen



-- Q3) Find all employees with first names 'Irena', 'Vidya', or 'Maya', and order your results returned by first name and then last name. 
-- In your comments, answer: What was the first and last name in the first row of the results? What was the first and last name of the last person in the table?

select emp_no, first_name, last_name from employees 
where first_name in ('Irena','Vidya','Maya') 
order by first_name, last_name;

-- A: 1st row= Irena Acton
-- A: last person= Vidya Zweizig

-- Q4) Find all employees with first names 'Irena', 'Vidya', or 'Maya', and order your results returned by last name and then first name. 
-- In your comments, answer: What was the first and last name in the first row of the results? What was the first and last name of the last person in the table?

select emp_no, first_name, last_name from employees 
where first_name in ('Irena','Vidya','Maya')
order by last_name, first_name;

-- A: 1st row= Irena Acton
-- A: last person= Maya Zyda

-- Q5) Write a query to find all employees whose last name starts and ends with 'E'. Sort the results by their employee number. 
-- Enter a comment with the number of employees returned, the first employee number and their first and last name, 
-- and the last employee number with their first and last name.

select *
from employees
where last_name like 'E%E'
order by emp_no;

-- A: 899
-- A: 10021 and Ramzi Erde
-- A: 499648 and Tadahiro Erdo

-- Q6) Write a query to find all employees whose last name starts and ends with 'E'. 
-- Sort the results by their hire date, so that the newest employees are listed first. 
-- Enter a comment with the number of employees returned, the name of the newest employee, and the name of the oldest employee.

select * 
from employees
where last_name like 'E%E'
order by hire_date desc;

-- A: 899
-- A: Sergi Erde
-- A: Teiji Eldridge





-- Q7) Find all employees hired in the 90s and born on Christmas. 
-- Sort the results so that the oldest employee who was hired last is the first result. 
-- Enter a comment with the number of employees returned, the name of the oldest employee who was hired last, and the name of the youngest employee who was hired first.


select *
from employees
where hire_date like '199%' and birth_date like '%-12-25'
order by birth_date, hire_date desc;


-- A: 362
-- A: Khun Bernini
-- A: Douadi Pettis






