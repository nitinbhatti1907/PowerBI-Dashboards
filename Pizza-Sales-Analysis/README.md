# 🍕 Pizza Sales Analysis | SQL Server + Power BI

An end-to-end sales analytics project built with **Microsoft SQL Server, SSMS, SQL, Power BI, and DAX** to analyze pizza sales performance, ordering trends, product mix, and best/worst-selling pizzas.

## 🎯 Project Objective

The goal of this project is to turn transactional pizza sales data into decision-ready business insights. The analysis combines SQL-based validation with an interactive Power BI report so that KPIs and visual results can be checked against the underlying source data.

## 🛠️ Tech Stack

- **Microsoft SQL Server 2025**
- **SQL Server Management Studio (SSMS)**
- **SQL**
- **Microsoft Power BI Desktop**
- **DAX**
- **Data Modeling**
- **Data Visualization & Business Intelligence**

## 📊 Dataset

- **48,620 sales line items**
- Transaction-level pizza order data
- Key fields include order ID, order date/time, pizza name, category, size, quantity, unit price, and total price

## 📌 Core KPIs

| KPI | Result |
|---|---:|
| Total Revenue | **$817,860.05** |
| Average Order Value | **$38.31** |
| Total Pizzas Sold | **49,574** |
| Total Orders | **21,350** |
| Average Pizzas per Order | **2.32** |

## ❓ Business Questions Solved

1. What is the total revenue generated?
2. What is the average value of each order?
3. How many pizzas were sold and how many unique orders were placed?
4. What is the average number of pizzas per order?
5. Which weekdays generate the most orders?
6. How does order volume change month by month?
7. What percentage of sales comes from each pizza category?
8. What percentage of sales comes from each pizza size?
9. Which pizzas are the **Top 5** and **Bottom 5** by revenue?
10. Which pizzas are the **Top 5** and **Bottom 5** by quantity sold?
11. Which pizzas are the **Top 5** and **Bottom 5** by total orders?

## 🔍 Key Insights

- **Friday** recorded the highest order volume with **3,538 orders**, while **Sunday** recorded the lowest with **2,624 orders**.
- **July** was the busiest month with **1,935 orders**.
- **Classic** pizzas contributed the largest category revenue at **$220,053.10 (26.91%)**.
- **Large (L)** pizzas generated the largest share of revenue at **$375,318.70 (45.89%)**.
- **The Thai Chicken Pizza** generated the highest revenue at **$43,434.25**.
- **The Classic Deluxe Pizza** led both quantity sold (**2,453**) and total orders (**2,329**).
- **The Brie Carre Pizza** ranked lowest by revenue (**$11,588.50**), quantity sold (**490**), and total orders (**480**).

## 🧩 Dashboard Structure

The Power BI report contains two pages:

### 1. Home
Executive KPI and sales-performance overview, including trend and sales-mix analysis.

### 2. Best/Worst Seller
Product-level analysis highlighting the highest- and lowest-performing pizzas across revenue, quantity, and order count.

## 🔄 Analytics Workflow

```text
Raw Sales Data
      ↓
SQL Server
      ↓
SQL Analysis in SSMS
      ↓
KPI / Business Rule Validation
      ↓
Power BI Data Model + DAX
      ↓
Interactive Dashboard
      ↓
Business Insights
```

## 🧠 SQL Skills Demonstrated

- Aggregate functions: `SUM()`, `COUNT()`, `COUNT(DISTINCT)`
- `GROUP BY` and `ORDER BY`
- `TOP`
- Percentage-of-total calculations
- Date analysis using `DATENAME()`, `DATEPART()`, and `MONTH()`
- Conditional sorting with `CASE`
- KPI validation and business-focused aggregation

## 📁 Project Structure

```text
Pizza-Sales-Analysis/
├── README.md
├── Pizza_Dashboard.pbix
├── Data/
│   └── pizza_sales.csv
└── SQL/
    └── pizza_sales_analysis.sql
```

## ▶️ How to Use

1. Open the dataset in SQL Server or import it into a database table named `pizza_sales`.
2. Run the queries in `SQL/pizza_sales_analysis.sql` using SSMS.
3. Open `Pizza_Dashboard.pbix` in Power BI Desktop.
4. Update the local SQL Server connection if Power BI requests source credentials.
5. Compare the dashboard KPIs with the SQL query outputs to validate the report.

## 📚 Project Source

This project was developed as a guided portfolio project based on the **Data Tutorials** YouTube walkthrough and then implemented locally using SQL Server 2025, SSMS, and Power BI.

Tutorial: https://www.youtube.com/watch?v=V-s8c6jMRN0

## 🚀 Portfolio Value

This project demonstrates an end-to-end BI workflow: translating business questions into SQL analysis, validating KPIs, building an interactive Power BI report, and communicating actionable sales insights.
