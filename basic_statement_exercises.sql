-- Basic Statements Exercises


-- Q1) use the albums_db database.

SHOW databases;
USE albums_db;

-- Q2) what is the primary key for the albums table?
describe albums;
-- field "id" is the primary key 

-- Q3) what does the column named 'name' represent?
-- Ans: The column named 'name' has the string datatype and it does not accept NuLL data
SELECT name FROM albums;

-- Q4) what do you think the sales column represents?
-- Ans: The column named 'sales' has the float datatype and it can accept NULL data also
SELECT Sales FROM albums;

-- Q5) find the name of all albums by Pink Floyd
SELECT name FROM albums WHERE artist='Pink Floyd';


-- Q6) What is the year Sgt. Pepper's Lonely Hearts Club Band was released?
SELECT * FROM albums;

SELECT release_date FROM albums WHERE name ="Sgt. Pepper's Lonely Hearts Club Band";

-- Q7) What is the genre for the album Nevermind?
SELECT genre FROM albums WHERE name ='Nevermind';

-- Q8) Which albums were released in the 1990s?
SELECT name FROM albums WHERE release_date=1990;

-- Q9) Which albums had less than 20 million certified sales? Rename this column as low_selling_albums.
SELECT name AS low_selling_albums FROM albums WHERE sales<20;

