CREATE DATABASE office;
USE offices;
CREATE TABLE customers(
customer_id INT,
customer_name VARCHAR(50),
city VARCHAR(50)
);
INSERT INTO customers VALUES
  (1,'John smith','New york'),
  (2,'Mary johnson','Chicago'),
  (3,'Peter Adams','Los Angeles'),
  (4,'Nancy Miller','Houston'),
  (5,'Robert White','Miami');
  
CREATE TABLE orders(
order_id INT PRIMARY KEY,
customer_id INT,
order_date DATE,
amount INT
);

INSERT INTO orders VALUES
(101,1,'2024-10-01',250),
(102,2,'2024-10-05',300),
(103,1,'2024-10-07',150),
(104,3,'2024-10-10',450),
(105,6,'2024-10-12',400);


CREATE TABLE Payments(
payment_id VARCHAR(50) PRIMARY KEY,
customer_id INT,
payment_date DATE,
amount int
);
INSERT INTO Payments VALUES
('P001',1,'2024-10-02',250),
('P002',2,'2024-10-06',300),
('P003',3,'2024-10-11',450),
('P004',4,'2024-10-15',200);

CREATE TABLE employees(
employee_id INT,
employee_name VARCHAR(50),
manager_id INT
);

INSERT INTO employees VALUES
(1,'Alex Green',NULL),
(2,'Brian Lee',1),
(3,'Carol Ray',1),
(4,'David Kim',2),
(5,'Eva Smith',3);

# Question 1. Retrieve all customers who have placed at least one order

SELECT * FROM customers
INNER JOIN orders ON customers.customer_id = orders.customer_id;

# Question 2. Retrieve all customers and their orders, including customers who have not placed any orders.

SELECT customers.customer_id,
       customers.customer_name,
       orders.order_id,
       Orders.amount
FROM customers
LEFT JOIN orders
ON customers.customer_id = orders.customer_id;

# Question 3. Retrieve all orders and their corresponding customers, including orders placed by unknown customers.

SELECT orders.order_id, orders.amount ,customers.customer_name	
FROM orders
LEFT JOIN customers
ON orders.customer_id= customers.customer_id;

# Question 4. Display all customers and orders, whether matched or not

SELECT customers.customer_id,customers.customer_name,orders.order_id,orders.amount
FROM customers
LEFT JOIN orders
ON customers.customer_id=orders.customer_id

UNION

SELECT customers.customer_id,customers.customer_name,orders.order_id,orders.amount
FROM customers
LEFT JOIN orders
ON customers.customer_id=orders.customer_id;


# Question 5. Find customers who have not placed any orders


SELECT
    customers.customer_id,
    customers.customer_name,
    customers.city
FROM customers
LEFT JOIN orders
ON customers.customer_id = orders.customer_id
WHERE orders.order_id IS NULL;

# Question 6. Retrieve customers who made payments but did not place any orders
SELECT DISTINCT
    customers.customer_id,
    customers.customer_name,
    customers.city
FROM customers
INNER JOIN payments
ON customers.customer_id = payments.customer_id
LEFT JOIN orders
ON customers.customer_id = orders.customer_id
WHERE orders.order_id IS NULL;

# Question 7. Generate a list of all possible combinations between Customers and Orders
SELECT
    customers.customer_id,
    customers.customer_name,
    orders.order_id,
    orders.order_date,
    orders.amount
FROM customers
CROSS JOIN orders;

# Question 8. Show all customers along with order and payment amounts in one table.
SELECT
    customers.customer_id,
    customers.customer_name,
    customers.city,
    orders.amount AS order_amount,
    payments.amount AS payment_amount
FROM customers
LEFT JOIN orders
ON customers.customer_id = orders.customer_id
LEFT JOIN payments
ON customers.customer_id = payments.customer_id;

#Question 9. Retrieve all customers who have both placed orders and made payments
SELECT DISTINCT
    customers.customer_id,
    customers.customer_name,
    customers.city
FROM customers
INNER JOIN orders
ON customers.customer_id = orders.customer_id
INNER JOIN payments
ON customers.customer_id = payments.customer_id;

