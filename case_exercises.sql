

-- Exercise Goals
-- Use CASE statements or IF() function to explore information in the employees database
-- Create a file named case_exercises.sql and craft queries to return the results for the following criteria:

/*
Q1) Write a query that returns all employees, their department number, their start date, their end date, and 
a new column 'is_current_employee' that is a 1 if the employee is still with the company and 0 if not. 
DO NOT WORRY ABOUT DUPLICATE EMPLOYEES.
*/

use employees;

select 
		emp_no,
        concat(first_name,' ',last_name) as full_name,
		dept_no,
        from_date,
        to_date,
		if(to_date>now(),1,0) As 'is_current_employee'

from dept_emp 
	join employees 
		using (emp_no)

order by emp_no asc
;









/*
Q2) Write a query that returns all employee names (previous and current), 
and a new column 'alpha_group' that returns 'A-H', 'I-Q', or 'R-Z' depending on the first letter of their last name.
*/


select 
		concat(first_name,' ',last_name),
        to_date,
        CASE 
			WHEN left(last_name,1) between 'A' and 'H' then 'A-H' 
            WHEN left(last_name,1) between 'I' and 'Q' then 'I-Q'
           -- WHEN left(last_name,1) between 'R' and 'Z' then 'R-Z'
		    ELSE 'R-Z'
		END AS alpha_group
from employees
	join dept_emp
		using(emp_no)
    
    ;

-- or 

select 
		concat(first_name,' ',last_name),
        to_date,
        CASE 
			WHEN substr(last_name,1) <= 'H'then 'A-H' 
            WHEN left(last_name,1) <= 'Q' then 'I-Q'
           -- WHEN left(last_name,1) between 'R' and 'Z' then 'R-Z'
		    ELSE 'R-Z'
		END AS alpha_group
from employees
	join dept_emp
		using(emp_no)
    
    ;





/*
Q3) How many employees (current or previous) were born in each decade?
*/


select min(birth_date),max(birth_date)
from employees;





select
		case
			when birth_date like '195%' then '50s'
            when birth_date like '196%' then '60s'
            else 'other'
		end AS 'birth_Decade'
        ,count(*) as 'no_decade_employees'
from employees
group by birth_Decade
;




/*
Q4) What is the current average salary for each of the following 
department groups: R&D, Sales & Marketing, Prod & QM, Finance & HR, Customer Service?
*/


select avg(salary)
from salaries;

select dept_name
from departments
group by dept_name;


select 
        case
			when d.dept_name in ('Research','Development') then 'R&D'
            when d.dept_name in ('Sales','Marketing') then 'Sales & Marketing'
            when d.dept_name in ('Production','Quality Management') then 'Prod & QM'
            when d.dept_name in ('Finance','Human Resources') then 'Finance & HR'
            else 'Customer Service'
		end AS 'department_groups'
        ,round(avg(s.salary),2) as avg_salary
from 
	departments d
    join dept_emp de
		on d.dept_no=de.dept_no
        and de.to_date>now()
	join salaries s
		on de.emp_no=s.emp_no
        and s.to_date>now()
group by department_groups
        
        ;
            


-- BONUS-------------------------------------------------------------------------------------------------------

-- BQ1) Remove duplicate employees from exercise 1.

-- finding max to_date for each employees/using this as our inner query
select 
	emp_no,
    max(to_date)
from dept_emp
group by emp_no
;


select 
		e.emp_no,
        concat(e.first_name,' ',e.last_name) as full_name,
		de.dept_no,
        de.from_date,
        de.to_date,
		if(de.to_date>now(),1,0) As 'is_current_employee'

from employees e
	join dept_emp de
		using (emp_no)
	join 
			(
            select 
					emp_no,
					max(to_date) as to_date
			from dept_emp
			group by emp_no
            
            ) as a
            on e.emp_no=a.emp_no
            and de.to_date=a.to_date
;


## Another Way


select 
	emp_no,
    dept_no,
    concat(first_name,' ',last_name) as full_name,
    to_date,
    if(to_date>curdate(),1,0) as 'is_current_employee'
from 
	employees 
join 
	dept_emp 
    using (emp_no)
where (emp_no,to_date) in (
							select emp_no,max(to_date)
                            from dept_emp
                            group by emp_no
						  )
	;	
    