create database Librarys;
use Librarys;
DROP DATABASE Librarys;

CREATE TABLE Branch (
  Branch_no INT PRIMARY KEY,
  Manager_Id INT,
  Branch_address VARCHAR(100),
  Contact_no VARCHAR(20)
);

INSERT INTO Branch VALUES
  (1, 101, 'THRISSUR','9746595251'),
  (2, 102,'IRINJALAKUDA','7902912023');
select * from Branch ;


CREATE TABLE Employees_details(
  Emp_Id INT PRIMARY KEY,
  Emp_name VARCHAR(50),
  Position VARCHAR(50),
  Salary INT,
  Branch_no INT,
  FOREIGN KEY (Branch_no) REFERENCES Branch(Branch_no)
);

INSERT INTO Employees_details value
  (2001, 'Abhiram','manager', 80000,1),
  (2002, 'Abhijith', 'Cashier', 30000, 1),
  (2003, 'Samju', 'Manager', 55000, 2);

 drop table Employees_details;
 
select * from Employees_details;

CREATE TABLE Customer_details(
  Customer_Id INT PRIMARY KEY,
  Customer_name VARCHAR(50),
  Customer_address VARCHAR(100),
  Reg_date DATE
);

INSERT INTO Customer_details value
  (301, 'Anju', 'kasargod','2021-04-20'),
  (302, 'faez', 'kannur','2021-02-28');
  
  DROP TABLE Customer_details;
  
select * from Customer_details;

create table IssueStatus (
  Issue_Id INT PRIMARY KEY, 
  Issued_cust INT,
  Issued_book_name VARCHAR(50),
  Issue_date DATE,
  Isbn_book INT,
  FOREIGN KEY (Issued_cust) REFERENCES Customer_details(Customer_Id),
  FOREIGN KEY (Isbn_book) REFERENCES Books(ISBN)
);
  insert into IssueStatus VALUES
  (401, 301, 'trissur','2022-01-16',1001);
 
 select * from IssueStatus;
 
 CREATE TABLE ReturnStatus (
  Return_Id INT PRIMARY KEY,
  Return_cust INT, 
  Return_book_name VARCHAR(50),
  Return_date DATE,
  Isbn_book2 INT,
  FOREIGN KEY (Isbn_book2) REFERENCES Books(ISBN)  
);
  INSERT INTO ReturnStatus VALUES
  (501, 301, ' kozikod', '2022-05-15', 1001);
  
  CREATE TABLE Books (
  ISBN INT PRIMARY KEY,
  Book_title VARCHAR(100), 
  Category VARCHAR(50),
  Rental_Price INT,
  Status VARCHAR(10),
  Author VARCHAR(50),
  Publisher VARCHAR(50)
);

INSERT INTO Books VALUES
  (1001, 'The Two Towers', 'Fiction', 499, 'Yes', 'peter S Beagle ', 'J.R.R. Tolkien');

select * from Books;


-- Retrieve the book title, category, and rental price of all available books


SELECT 
  book_title, 
  category,
  rental_price
FROM books
WHERE status = 'yes';

-- List the employee names and their respective salaries in descending order of salary.

SELECT
  emp_name,
  salary
FROM Employees_details
ORDER BY salary DESC;

-- Retrieve the book titles and the corresponding customers who have issued those books.

SELECT
  b.book_title,
  c.customer_name
FROM issuestatus i
JOIN Customer_details c ON i.issued_cust = c.customer_id  
JOIN books b ON i.isbn_book = b.isbn;


-- Display the total count of books in each category.

SELECT 
  category,
  COUNT(*) AS total_books 
FROM books
GROUP BY category;

-- Retrieve the employee names and their positions for the employees whose salaries are above Rs.50,000.

SELECT
  emp_name, 
  position
FROM Employees_details
WHERE salary > 50000;

-- List the customer names who registered before 2022-01-01 and have not issued any books yet.

SELECT
  c.customer_name
FROM Customer_details c
WHERE c.reg_date < '2022-01-01'
AND c.customer_id NOT IN (
  SELECT issued_cust 
  FROM issuestatus
);

-- Display the branch numbers and the total count of employees in each branch.

SELECT
  branch_no,
  COUNT(emp_id) AS total_employees
FROM Employees_details
GROUP BY branch_no;


-- Display the names of customers who have issued books in the month of June 2023.

SELECT
  c.customer_name
FROM Customer_details c 
JOIN issuestatus i ON c.customer_id = i.issued_cust
WHERE i.issue_date BETWEEN '2023-06-01' AND '2023-06-30';


 -- Retrieve book_title from book table containing history. 10.Retrieve the branch numbers along with the count of employees for branches
 -- having more than 5 employees.


SELECT book_title  
FROM books
WHERE book_title LIKE '%history%';

SELECT branch_no, COUNT(emp_id) AS employees
FROM Employees_details  
GROUP BY branch_no
HAVING COUNT(emp_id) > 5;