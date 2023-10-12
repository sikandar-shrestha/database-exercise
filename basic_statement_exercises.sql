-- Basic Statements Exercises


-- Q1) use the albums_db database.

show databases;
use albums_db;

-- Q2) what is the primary key for the albums table?
describe albums;
-- field "id" is the primary key 

-- Q3) what does the column named 'name' represent?
-- Ans: The column named 'name' has the string datatype and it does not accept NuLL data
select name from albums;

-- Q4) what do you think the sales column represents?
-- Ans: The column named 'sales' has the float datatype and it can accept NULL data also
select Sales from albums;

-- Q5) find the name of all albums by Pink Floyd
select name from albums where artist='Pink Floyd';


-- Q6) What is the year Sgt. Pepper's Lonely Hearts Club Band was released?
select * from albums;

select release_date from albums where name ="Sgt. Pepper's Lonely Hearts Club Band";

-- Q7) What is the genre for the album Nevermind?
select genre from albums where name ='Nevermind';

-- Q8) Which albums were released in the 1990s?
select name from albums where release_date=1990;

-- Q9) Which albums had less than 20 million certified sales? Rename this column as low_selling_albums.
select name as low_selling_albums from albums where sales<20;

