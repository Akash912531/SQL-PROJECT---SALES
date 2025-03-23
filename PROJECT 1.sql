Create database online_book_store;
use online_book_store;
-- 1) Retrieve all books in the "fiction" genre:
SELECT * FROM  Books
WHERE genre =  'Fiction';

-- 2) Find Books Published after the year 1950 : 
SELECT * FROM Books 
WHERE Published_Year > 1950;
 
-- 3) List all customer from the Canada:
SELECT * FROM customers
WHERE Country = "Canada";

-- 4) Show Orders placed in November 2023:
SELECT * FROM Orders
WHERE Order_Date BETWEEN '2023-11-01' AND '2023-11-30';

-- 5) Retrieve the total stocks of books available:
SELECT SUM(stock) AS Total_stocks
FROM Books;

-- 6) Find the details of the most expensive book;
SELECT * FROM Books 
ORDER BY Price
 DESC LIMIT 1;

-- 7) Show all customers who ordered more than 1 Quantity of a Book:
SELECT  * FROM orders
WHERE Quantity>1;

-- 8) Retrieve all orders where the total amount exceed $20:
SELECT * FROM Orders 
WHERE Total_amount>20;

-- 9) List all genres available in the Books table:
SELECT DISTINCT  Genre 
FROM Books;


-- 10) Find the book with the lowest stock:
SELECT * FROM Books 
ORDER BY
stock LIMIT 1;

-- 11) Calculate the total revenue genreted from all orders:
SELECT SUM(Total_Amount) AS Revenue
FROM orders;


-- Advance Queries:

-- 1) Retrieve the total number of books sold for each genre:
SELECT b.Genre, SUM(o.Quantity) AS Total_Books_sold 
FROM Orders o 
JOIN Books b ON o.book_id = b.book_id
GROUP BY b.Genre;


-- 2) Find the average price of books in the "Fantasy" genre:
 SELECT AVG(price) AS Average_price 
 FROM Books
 WHERE Genre = 'Fantasy';
 
 -- 3) List customers who have placed at least 2 orders:
 SELECT o.customer_id, c.name, COUNT(o.Order_id) as ORDER_COUNT
 FROM orders o
 JOIN customers c ON o.customer_id=c.customer_id
 GROUP BY customer_id, c.name
 HAVING COUNT(order_id) >=2;
 
 
 -- 4) Find the most frequently ordered book :
 SELECT o.Book_id, b.Title, COUNT(o.order_id) AS ORDER_COUNT
 FROM orders o
 JOIN books b ON o.book_id=b.book_id
 GROUP BY o.Book_id, b.title
 ORDER BY ORDER_COUNT DESC LIMIT 1;

 
 -- 5) Show the top 3 most expensive books of 'Fantasy' Genre :
 SELECT * FROM books
 WHERE genre ='Fantasy'
 ORDER BY price DESC LIMIT 3;
 
 
 -- 6) Retrieve the total quantity of books sold by each author :
 SELECT b.author, SUM(o.quantity) AS Total_Books_Sold
 FROM orders o
 JOIN books b ON  o.book_id = b.Book_ID
 GROUP BY  b.Author;
 
 
 -- 7) List the cities where customer who spent over $30 are located : 
 SELECT DISTINCT c.city, total_amount
 FROM orders o
 JOIN customers c ON o.customer_id = c.customer_id
 WHERE o.total_amount > 30;
 
 
 -- 8) Find the customer who spent the most on orders :
 SELECT c.customer_id, c.name, SUM(o.total_amount) AS Total_Spent
 FROM orders o 
 JOIN customers c ON o.customer_id = o.customer_id
 GROUP BY c.customer_id, c.name
 ORDER BY Total_spent DESC LIMIT 1;
 
 
 -- 9) Calculate the stock remaining after fulfilling all orders;
 SELECT b.book_id, b.title, b.stock, coalesce(SUM(o.quantity),0) AS Order_quantity,
 b.stock- COALESCE(SUM(o.quantity),0) AS Remaining_Quantity
 FROM books  as b
 LEFT JOIN orders as o ON b.book_id=o.book_id
 GROUP BY b.book_id ,b.Title,b.stock;