🍕 Pizza Sales Analysis – SQL Server Project
📌 Project Overview

This project analyzes pizza sales data using Microsoft SQL Server (SSMS) to uncover key business insights such as revenue trends, customer ordering behavior, and top-performing pizzas.
The project progresses from basic SQL queries to advanced analytics using window functions and CTEs.

🛠 Tools & Technologies

Database: Microsoft SQL Server

Query Tool: SQL Server Management Studio (SSMS)

Language: SQL

Data Source: CSV files (Orders, Order Details, Pizzas, Pizza Types)

🗂 Database Schema
Tables Used

orders

order_id (PK)

date

time

order_details

order_details_id (PK)

order_id (FK)

pizza_id

quantity

pizzas

pizza_id (PK)

pizza_type_id

size

price

pizza_types

pizza_type_id (PK)

name

category

ingredients

📊 Analysis Performed
🔹 Basic SQL Analysis

Total number of orders placed

Total revenue generated from pizza sales

Highest priced pizza

Most common pizza size ordered

Top 5 most ordered pizza types by quantity

🔹 Intermediate SQL Analysis

Total quantity ordered by pizza category

Order distribution by hour of the day

Category-wise order distribution

Average number of pizzas ordered per day

Top 3 pizza types based on revenue

🔹 Advanced SQL Analysis

Percentage contribution of each pizza type to total revenue

Cumulative revenue generated over time (window functions)

Top 3 pizzas by revenue within each category (CTE + ranking)

🧠 Key SQL Concepts Used

JOIN (INNER JOIN)

GROUP BY & aggregate functions

Subqueries

Common Table Expressions (CTE)

Window Functions (OVER, RANK)

Date & Time functions

Handling reserved keywords ([date], [time])

Data type optimization (DECIMAL vs FLOAT)

📈 Sample Advanced Query
SELECT 
    o.[date] AS order_date,
    SUM(od.quantity * p.price) AS daily_revenue,
    SUM(SUM(od.quantity * p.price)) 
        OVER (ORDER BY o.[date]) AS cumulative_revenue
FROM orders o
JOIN order_details od ON o.order_id = od.order_id
JOIN pizzas p ON od.pizza_id = p.pizza_id
GROUP BY o.[date]
ORDER BY o.[date];

✅ Business Insights

Identified peak ordering hours

Determined highest revenue-generating pizzas

Analyzed category-wise performance

Tracked revenue growth over time

Supported data-driven decision making

📌 How to Run This Project

Create a database in SQL Server

Import CSV files using Import Flat File Wizard

Verify table schemas and data types

Execute SQL queries in order (Basic → Advanced)

🚀 Future Enhancements

Power BI dashboard for visualization

Stored procedures for automation

Indexing for performance optimization

Monthly & quarterly trend analysis

👤 Author

Roshan
📊 Aspiring Data Analyst | SQL | Power BI | Analytics
📌 Open to data analyst opportunities
