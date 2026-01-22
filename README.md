# 🍕 Pizza Sales Analysis | SQL Server Project

## 📌 Project Overview
This project is an end-to-end **SQL Server data analysis project** focused on analyzing pizza sales data to derive meaningful business insights.  
Using **Microsoft SQL Server (SSMS)**, raw CSV data was imported, structured into relational tables, and analyzed using **basic to advanced SQL queries**.

The project demonstrates a strong understanding of **database design, data cleaning, joins, aggregations, and analytical SQL concepts** commonly used by Data Analysts.

---

## 🛠 Tools & Technologies
- **Database:** Microsoft SQL Server  
- **Query Tool:** SQL Server Management Studio (SSMS)  
- **Language:** SQL  
- **Data Format:** CSV files  

---

## 🗂 Dataset Description
The analysis is based on four datasets:

- **orders.csv** – order date and time information  
- **order_details.csv** – pizzas ordered and quantities  
- **pizzas.csv** – pizza size and price details  
- **pizza_types.csv** – pizza names, categories, and ingredients  

---

## 🧱 Database Schema

### 1️⃣ orders
| Column | Description |
|------|------------|
| order_id | Unique order identifier |
| date | Order date |
| time | Order time |

### 2️⃣ order_details
| Column | Description |
|------|------------|
| order_details_id | Unique row identifier |
| order_id | Order reference |
| pizza_id | Pizza reference |
| quantity | Number of pizzas ordered |

### 3️⃣ pizzas
| Column | Description |
|------|------------|
| pizza_id | Unique pizza identifier |
| pizza_type_id | Pizza type reference |
| size | Pizza size (S, M, L, XL) |
| price | Pizza price |

### 4️⃣ pizza_types
| Column | Description |
|------|------------|
| pizza_type_id | Pizza type identifier |
| name | Pizza name |
| category | Pizza category |
| ingredients | Ingredients used |

---

## 📊 Analysis Performed

### 🔹 Basic SQL Analysis
- Total number of orders placed  
- Total revenue generated from pizza sales  
- Highest priced pizza  
- Most common pizza size ordered  
- Top 5 most ordered pizza types  

---

### 🔹 Intermediate SQL Analysis
- Total quantity ordered by pizza category  
- Hour-wise order distribution  
- Category-wise order distribution  
- Average number of pizzas ordered per day  
- Top 3 pizza types based on revenue  

---

### 🔹 Advanced SQL Analysis
- Percentage contribution of each pizza to total revenue  
- Cumulative revenue analysis using window functions  
- Top 3 pizzas by revenue within each category  

---

## 🧠 SQL Concepts Used
- INNER JOINs
- GROUP BY & aggregate functions
- Subqueries
- Common Table Expressions (CTEs)
- Window functions (`OVER`, `RANK`)
- Date & time functions
- Handling reserved keywords (`[date]`, `[time]`)
- Data type optimization (`DECIMAL` for pricing)

---

## 📈 Sample Query (Cumulative Revenue)

```sql
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
