-- Exercise Goals

-- Use join, left join, and right join statements on our Join Example DB
-- Integrate aggregate functions and clauses into our queries with JOIN statements
-- Create a file named join_exercises.sql to do your work in.

-- Join Example Database

-- Q1) Use the join_example_db. Select all the records from both the users and roles tables.

USE join_example_db;
select database();
show tables;
describe roles;
describe users;

select * from roles;
select * from users;

/*
Q2) Use join, left join, and right join to combine results from the users and roles tables as we did in the lesson. 
Before you run each query, guess the expected number of results.
*/

-- INNER JOIN
SELECT r.name as roles_name, u.name as users_name, email, role_id
FROM roles r
JOIN users u
ON r.id=u.id;


-- LEFT JOIN

SELECT *
FROM roles r
left join users u
	on r.id=u.role_id;


-- right join

select *
from roles r
right join users u
	on r.id=u.role_id;






/*
Q3) Although not explicitly covered in the lesson, aggregate functions like count can be used with join queries. 
Use count and the appropriate join type to get a list of roles along with the number of users that have the role. 
Hint: You will also need to use group by in the query.
*/

SELECT  r.name as role_name,count(*) as cnt
FROM roles r
left JOIN users u
ON r.id=u.role_id
group by role_name;







-- Employees Database

-- 1. Use the employees database.

USE employees;
select database();
describe departments;
describe dept_emp;
describe dept_manager;
describe employees;
describe salaries;
describe titles;


/*
 2. Using the example in the Associative Table Joins section as a guide, 
 write a query that shows each department along with the name of the current manager for that department.

  Department Name    | Department Manager
 --------------------+--------------------
  Customer Service   | Yuchang Weedman
  Development        | Leon DasSarma
  Finance            | Isamu Legleitner
  Human Resources    | Karsten Sigstam
  Marketing          | Vishwani Minakawa
  Production         | Oscar Ghazalie
  Quality Management | Dung Pesch
  Research           | Hilary Kambil
  Sales              | Hauke Zhang
*/

-- Associative Tables are : departments,dept_manager, employees
select
		d.dept_name as department_Name, concat(e.first_name,' ',e.last_name) as department_manager
from departments d
inner join dept_manager dm
	on d.dept_no=dm.dept_no
inner join employees e
	on dm.emp_no=e.emp_no
where dm.to_date='9999-01-01'
order by department_Name asc ;









/*
-- 3. Find the name of all departments currently managed by women.

Department Name | Manager Name
----------------+-----------------
Development     | Leon DasSarma
Finance         | Isamu Legleitner
Human Resources | Karsetn Sigstam
Research        | Hilary Kambil
*/


select d.dept_name, concat(e.first_name,' ',e.last_name) as Manager_Name,e.gender
from departments d
join dept_manager dm
	on d.dept_no=dm.dept_no
join employees e
	on dm.emp_no=e.emp_no
where e.gender='f'
group by d.dept_name;





/*
-- 4. Find the current titles of employees currently working in the Customer Service department.

Title              | Count
-------------------+------
Assistant Engineer |    68
Engineer           |   627
Manager            |     1
Senior Engineer    |  1790
Senior Staff       | 11268
Staff              |  3574
Technique Leader   |   241
*/

-- Associative tables : titles,dept_emp, departments

select t.title, count(*) as Count
from titles t
join dept_emp de
	on t.emp_no=de.emp_no
join departments d
	on de.dept_no=d.dept_no
where  d.dept_name='Customer Service' and t.to_date='9999-01-01'
group by t.title
order by t.title ;


/*
-- 5. Find the current salary of all current managers.

Department Name    | Name              | Salary
-------------------+-------------------+-------
Customer Service   | Yuchang Weedman   |  58745
Development        | Leon DasSarma     |  74510
Finance            | Isamu Legleitner  |  83457
Human Resources    | Karsten Sigstam   |  65400
Marketing          | Vishwani Minakawa | 106491
Production         | Oscar Ghazalie    |  56654
Quality Management | Dung Pesch        |  72876
Research           | Hilary Kambil     |  79393
Sales              | Hauke Zhang       | 101987
*/


-- tables (departments, dept_manager, employees, salaries)


select d.dept_name, concat(e.first_name,' ',e.last_name) as Name,s.salary as Salary
from departments d
join dept_manager dm
	on d.dept_no=dm.dept_no
join  employees e
	on dm.emp_no=e.emp_no
join salaries s
	on e.emp_no=s.emp_no 
where s.to_date='9999-01-01' and dm.to_date='9999-01-01'
order by d.dept_name
;

/*
-- 6. Find the number of current employees in each department.

+---------+--------------------+---------------+
| dept_no | dept_name          | num_employees |
+---------+--------------------+---------------+
| d001    | Marketing          | 14842         |
| d002    | Finance            | 12437         |
| d003    | Human Resources    | 12898         |
| d004    | Production         | 53304         |
| d005    | Development        | 61386         |
| d006    | Quality Management | 14546         |
| d007    | Sales              | 37701         |
| d008    | Research           | 15441         |
| d009    | Customer Service   | 17569         |
+---------+--------------------+---------------+
*/

-- Associative tables : departments, dept_emp

select 
		d.dept_no, d.dept_name, count(*) as num_employees
from departments d
join dept_emp de
	on d.dept_no=de.dept_no
where de.to_date='9999-01-01'
group by d.dept_name
order by d.dept_no;


/*
-- 7. Which department has the highest average salary? Hint: Use current not historic information.

+-----------+----------------+
| dept_name | average_salary |
+-----------+----------------+
| Sales     | 88852.9695     |
+-----------+----------------+
*/

-- Associative tables : departments,dept_emp,salaries


select d.dept_name, avg(s.salary) as average_salary
from departments d
join dept_emp de
	on d.dept_no=de.dept_no
join salaries s
	on de.emp_no=s.emp_no
-- where s.to_date='9999-01-01'
where s.to_date>curdate()
group by d.dept_name
order by average_salary desc
limit 1;





/*
-- 8. Who is the highest paid employee in the Marketing department?

+------------+-----------+
| first_name | last_name |
+------------+-----------+
| Akemi      | Warwick   |
+------------+-----------+
*/


select e.first_name,e.last_name,s.salary
from salaries s
join employees e
	on s.emp_no=e.emp_no
join dept_emp de
	on e.emp_no=de.emp_no
join departments d
	on de.dept_no=d.dept_no
where d.dept_name='Marketing' 
order by s.salary desc
limit 1
;



/*
-- 9. Which current department manager has the highest salary?

+------------+-----------+--------+-----------+
| first_name | last_name | salary | dept_name |
+------------+-----------+--------+-----------+
| Vishwani   | Minakawa  | 106491 | Marketing |
+------------+-----------+--------+-----------+
*/


select e.first_name,e.last_name,s.salary,d.dept_name
from departments d
join dept_manager dm
	on d.dept_no=dm.dept_no
join employees e
	on dm.emp_no=e.emp_no
join salaries s
	on e.emp_no=s.emp_no
where dm.to_date='9999-01-01'
order by s.salary desc
limit 1;




/*

-- 10. Determine the average salary for each department. Use all salary information and round your results.

+--------------------+----------------+
| dept_name          | average_salary | 
+--------------------+----------------+
| Sales              | 80668          | 
+--------------------+----------------+
| Marketing          | 71913          |
+--------------------+----------------+
| Finance            | 70489          |
+--------------------+----------------+
| Research           | 59665          |
+--------------------+----------------+
| Production         | 59605          |
+--------------------+----------------+
| Development        | 59479          |
+--------------------+----------------+
| Customer Service   | 58770          |
+--------------------+----------------+
| Quality Management | 57251          |
+--------------------+----------------+
| Human Resources    | 55575          |
+--------------------+----------------+
*/


select d.dept_name,round(avg(s.salary),0) as average_salary
from departments d
join dept_emp de
	on d.dept_no=de.dept_no
join salaries s
	on de.emp_no=s.emp_no
group by d.dept_name
order by average_salary desc;






/*

-- 11. Bonus Find the names of all current employees, their department name, and their current manager's name.

240,124 Rows

Employee Name | Department Name  |  Manager Name
--------------|------------------|-----------------
 Huan Lortz   | Customer Service | Yuchang Weedman

 .....
 
 
 
 */
 
 
 -- Associative tables:- employees,dept_emp,departments,dept_manager,employees e2
 
 
 select 
	concat(e.first_name,' ',e.last_name)  as Employee_Name,
    d.dept_name as Department_Name,
    concat(e2.first_name,' ',e2.last_name) as Manager_Name
    
 from employees e
 join dept_emp de
	on e.emp_no=de.emp_no
join departments d
	on de.dept_no=d.dept_no
join dept_manager dm
	on d.dept_no=dm.dept_no
join employees e2
	on dm.emp_no=e2.emp_no
where dm.to_date > curdate() and de.to_date > curdate()
order by Department_Name asc;
 
 
 
 
 
 
 
 
 
 
 