CREATE DATABASE PizzaSalesDB;
GO
USE PizzaSalesDB;

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    order_date DATE,
    order_time TIME
);

CREATE TABLE order_details (
    order_details_id INT PRIMARY KEY,
    order_id INT,
    pizza_id VARCHAR(50),
    quantity INT,
    FOREIGN KEY (order_id) REFERENCES orders(order_id)
);

CREATE TABLE pizzas (
    pizza_id VARCHAR(50) PRIMARY KEY,
    pizza_type_id VARCHAR(50),
    size VARCHAR(5),
    price DECIMAL(5,2)
);

CREATE TABLE pizza_types (
    pizza_type_id VARCHAR(50) PRIMARY KEY,
    name VARCHAR(100),
    category VARCHAR(50),
    ingredients VARCHAR(255)
);

select * from order_details
select * from orders
select * from pizza_types
select * from pizzas

--1️ Total number of orders placed
SELECT COUNT(order_id) AS total_orders
FROM orders;

--2.Total revenue from pizza sales
SELECT 
    SUM(od.quantity * p.price) AS total_revenue
FROM order_details od
JOIN pizzas p
ON od.pizza_id = p.pizza_id;

--3.Highest priced pizza
SELECT TOP 1 
    pt.name,
    p.price
FROM pizzas p
JOIN pizza_types pt
ON p.pizza_type_id = pt.pizza_type_id
ORDER BY p.price DESC;

--4.Most common pizza size ordered
SELECT 
    p.size,
    COUNT(*) AS total_orders
FROM order_details od
JOIN pizzas p
ON od.pizza_id = p.pizza_id
GROUP BY p.size
ORDER BY total_orders DESC;

--5.Top 5 most ordered pizza types (by quantity)
SELECT TOP 5
    pt.name,
    SUM(od.quantity) AS total_quantity
FROM order_details od
JOIN pizzas p
ON od.pizza_id = p.pizza_id
JOIN pizza_types pt
ON p.pizza_type_id = pt.pizza_type_id
GROUP BY pt.name
ORDER BY total_quantity DESC;

--6.Total quantity ordered for each pizza category
SELECT 
    pt.category,
    SUM(od.quantity) AS total_quantity
FROM order_details od
JOIN pizzas p ON od.pizza_id = p.pizza_id
JOIN pizza_types pt ON p.pizza_type_id = pt.pizza_type_id
GROUP BY pt.category;

--7. Order distribution by hour of the day
SELECT 
    DATEPART(HOUR, [time]) AS order_hour,
    COUNT(order_id) AS total_orders
FROM orders
GROUP BY DATEPART(HOUR, [time])
ORDER BY order_hour;

--8.Category-wise distribution of pizzas
SELECT 
    pt.category,
    COUNT(DISTINCT od.order_id) AS total_orders
FROM order_details od
JOIN pizzas p ON od.pizza_id = p.pizza_id
JOIN pizza_types pt ON p.pizza_type_id = pt.pizza_type_id
GROUP BY pt.category;

--9 .Average number of pizzas ordered per day
SELECT 
    AVG(total_pizzas) AS avg_pizzas_per_day
FROM (
    SELECT 
        o.[date] AS order_date,
        SUM(od.quantity) AS total_pizzas
    FROM orders o
    JOIN order_details od 
        ON o.order_id = od.order_id
    GROUP BY o.[date]
) daily_orders;


--10.Top 3 pizza types by revenue
SELECT TOP 3
    pt.name,
    SUM(od.quantity * p.price) AS revenue
FROM order_details od
JOIN pizzas p ON od.pizza_id = p.pizza_id
JOIN pizza_types pt ON p.pizza_type_id = pt.pizza_type_id
GROUP BY pt.name
ORDER BY revenue DESC;

--1️1 Percentage contribution of each pizza type to total revenue
SELECT 
    pt.name,
    SUM(od.quantity * p.price) AS revenue,
    ROUND(
        (SUM(od.quantity * p.price) * 100.0) /
        (SELECT SUM(od.quantity * p.price) FROM order_details od JOIN pizzas p ON od.pizza_id = p.pizza_id),
        2
    ) AS revenue_percentage
FROM order_details od
JOIN pizzas p ON od.pizza_id = p.pizza_id
JOIN pizza_types pt ON p.pizza_type_id = pt.pizza_type_id
GROUP BY pt.name
ORDER BY revenue_percentage DESC;

--12.Cumulative revenue over time

SELECT 
    o.[date] AS order_date,
    SUM(od.quantity * p.price) AS daily_revenue,
    SUM(SUM(od.quantity * p.price)) 
        OVER (ORDER BY o.[date]) AS cumulative_revenue
FROM orders o
JOIN order_details od 
    ON o.order_id = od.order_id
JOIN pizzas p 
    ON od.pizza_id = p.pizza_id
GROUP BY o.[date]
ORDER BY o.[date];


--13 Top 3 pizzas by revenue within each category

WITH RankedPizzas AS (
    SELECT
        pt.category,
        pt.name,
        SUM(od.quantity * p.price) AS revenue,
        RANK() OVER (PARTITION BY pt.category ORDER BY SUM(od.quantity * p.price) DESC) AS rank_no
    FROM order_details od
    JOIN pizzas p ON od.pizza_id = p.pizza_id
    JOIN pizza_types pt ON p.pizza_type_id = pt.pizza_type_id
    GROUP BY pt.category, pt.name
)
SELECT *
FROM RankedPizzas
WHERE rank_no <= 3;












