use ursula_2342;



select database();
show tables;





-- Exercises

-- Create a file named temporary_tables.sql to do your work for this exercise.


/*

Q1) Using the example from the lesson, create a temporary table called employees_with_departments 
    that contains first_name, last_name, and dept_name for employees currently with that department. 
    Be absolutely sure to create this table on your own database. 
    If you see "Access denied for user ...", it means that the query was attempting to write a new table to a database that you can only read.


													
a) Add a column named full_name to this table.
   It should be a VARCHAR whose length is the sum of the lengths of the first name and last name columns.


b) Update the table so that the full_name column contains the correct data.
   Remove the first_name and last_name columns from the table.


c) What is another way you could have ended up with this same table?
*/


create temporary table employees_with_departments AS
													select emp_no, first_name,last_name,dept_no,dept_name
                                                    from employees.employees 
                                                    join employees.dept_emp using (emp_no)
                                                    join employees.departments using (dept_no)
                                                    where to_date>now()
                                                    limit 20
                                                    ;

select * from employees_with_departments;
													
-- a)
alter table employees_with_departments add full_name varchar(30);

select * from employees_with_departments;

update employees_with_departments set full_name=concat(first_name,' ',last_name);

select * from employees_with_departments;


-- b
alter table employees_with_departments drop column first_name, drop column last_name;

select * from employees_with_departments;


-- c




/*
Q2) Create a temporary table based on the payment table from the sakila database.
	Write the SQL necessary to transform the amount column such that it is stored 
	as an integer representing the number of cents of the payment. 
	For example, 1.99 should become 199.
*/

select * from sakila.payment;

create temporary table cent_payment as
										select amount
                                        from sakila.payment
                                        limit 20;
select * from cent_payment;

alter table cent_payment add amt_cent int;

select * from cent_payment;


update cent_payment set amt_cent=amount*100;

select * from cent_payment;



--  or ------------------------------

create temporary table amt_to_cent as
										select 
                                        amount,
                                        cast(amount*100 as signed) as cent_amt
                                        from sakila.payment
                                        ;
select * from amt_to_cent;
                                        
                                        





/*
Q3) Go back to the employees database. 
    Find out how the current average pay in each department compares to the overall current pay for everyone at the company.
    For this comparison, you will calculate the z-score for each salary. 
    In terms of salary, what is the best department right now to work for? The worst?
*/



create temporary table temp_dept_sal as 
select 
	    de.emp_no,
        d.dept_name,
        s.salary,
        avg(s.salary) over() as overall_avg_sal,
        stddev(s.salary) over() as overall_std_sal
from employees.salaries s join employees.dept_emp de on s.emp_no=de.emp_no 
join employees.departments d on de.dept_no=d.dept_no 
where s.to_date>curdate() and de.to_date>curdate()
;

select * from temp_dept_sal;





select 
	dept_name,
    avg(salary) as avg_dept_sal,
    (avg(salary)-overall_avg_sal)/overall_std_sal as z_score

from temp_dept_sal
group by dept_name, overall_avg_sal,overall_std_sal;

;


select min(z_score),max(z_score) 
from (
		select 
	dept_name,
    avg(salary) as avg_dept_sal,
    (avg(salary)-overall_avg_sal)/overall_std_sal as z_score

		from temp_dept_sal
		group by dept_name, overall_avg_sal,overall_std_sal
)as a

;
		
-- min z_score is -0.4673804203330646 (Human Resources)
-- max z_score is 0.9728927285775602 (Sales)
        
-- Hence, in terms of salary , Sales is the best department and Human Resources is worst department.










------------------------------- Bonus-------------------------------------------------------------------
/*
BONUS Determine the overall historic average department average salary, the historic overall average, and the historic z-scores for salary. 
Do the z-scores for current department average salaries (from exercise 3) tell a similar or a different story than the historic department salary z-scores?

*/

create temporary table hist_overall_sal as
											select 
													de.emp_no,
                                                    d.dept_name,
                                                    s.salary,
                                                    avg(s.salary) over() as overall_avg,
                                                    std(s.salary) over() as overall_std
                                            
                                              from employees.salaries s
                                              join employees.dept_emp de on s.emp_no=de.emp_no and s.to_date < now()
											  join employees.departments d on de.dept_no=d.dept_no and de.to_date< now()
                                              
											 ;
                                                                    
select * from hist_overall_sal;

drop table hist_overall_sal;

select 
		
        dept_name,
        avg(salary) as dept_avg,
        overall_avg,
        overall_std,
        (avg(salary)-overall_avg)/overall_std as z_score
        
from hist_overall_sal
group by dept_name,overall_avg,overall_std
        
        ;


select min(z_score),max(z_score)
from 
	(
    select 
		
        dept_name,
        avg(salary) as dept_avg,
        overall_avg,
        overall_std,
        (avg(salary)-overall_avg)/overall_std as z_score
        
from hist_overall_sal
group by dept_name,overall_avg,overall_std
        
    
    )a
;
-- in term of salary and histotic department wise salary
-- min(z_score) = -0.5317343693470233 (Humand Resources)
-- max(z_score) = 1.0424306409780846  (Sales)
