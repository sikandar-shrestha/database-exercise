-- Basic Statements Exercises


-- Q1) use the albums_db database.

SHOW databases; -- only to know the database
USE albums_db;

-- Q2) what is the primary key for the albums table?
describe albums;
select * from albums;-- no required if above code shows primary key
-- field "id" is the primary key 

-- Q3) what does the column named 'name' represent?
-- Ans: The name column represents album name
SELECT name FROM albums;

-- Q4) what do you think the sales column represents?
-- Ans: The sales column represents album sales
SELECT Sales FROM albums;

-- Q5) find the name of all albums by Pink Floyd
SELECT name FROM albums WHERE artist='Pink Floyd';


-- Q6) What is the year Sgt. Pepper's Lonely Hearts Club Band was released?
SELECT * FROM albums;-- just observe the table 

SELECT release_date FROM albums WHERE name ="Sgt. Pepper's Lonely Hearts Club Band";

-- OR

SELECT release_date FROM albums WHERE name ='Sgt. Pepper\'s Lonely Hearts Club Band';

-- Q7) What is the genre for the album Nevermind?
SELECT genre FROM albums WHERE name ='Nevermind';

-- Q8) Which albums were released in the 1990s?
SELECT name FROM albums WHERE release_date>=1990 and release_date<2000;

-- OR

SELECT name FROM albums 
WHERE release_date between 1990 and 2000 
order by release_date desc;

-- Q9) Which albums had less than 20 million certified sales? Rename this column as low_selling_albums.
SELECT name AS low_selling_albums 
FROM albums 
WHERE sales<20 
order by Sales;

