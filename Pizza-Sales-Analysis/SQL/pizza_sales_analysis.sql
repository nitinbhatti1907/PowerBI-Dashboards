/*
    Pizza Sales Analysis
    Tools: Microsoft SQL Server / SSMS

    The queries below cover KPI calculation, time-based order trends,
    sales mix, and best/worst product performance.
*/

-- =========================================================
-- A. CORE KPIs
-- =========================================================

-- 1. Total Revenue
SELECT
    CAST(SUM(total_price) AS DECIMAL(12, 2)) AS Total_Revenue
FROM pizza_sales;


-- 2. Average Order Value
SELECT
    CAST(SUM(total_price) / COUNT(DISTINCT order_id) AS DECIMAL(10, 2)) AS Avg_Order_Value
FROM pizza_sales;


-- 3. Total Pizzas Sold
SELECT
    SUM(quantity) AS Total_Pizzas_Sold
FROM pizza_sales;


-- 4. Total Orders
SELECT
    COUNT(DISTINCT order_id) AS Total_Orders
FROM pizza_sales;


-- 5. Average Pizzas Per Order
SELECT
    CAST(
        CAST(SUM(quantity) AS DECIMAL(10, 2))
        / CAST(COUNT(DISTINCT order_id) AS DECIMAL(10, 2))
        AS DECIMAL(10, 2)
    ) AS Avg_Pizzas_Per_Order
FROM pizza_sales;


-- =========================================================
-- B. ORDER TRENDS
-- =========================================================

-- 6. Daily Trend for Total Orders
-- CASE is used so weekdays display Monday -> Sunday.
SELECT
    DATENAME(WEEKDAY, order_date) AS Order_Day,
    COUNT(DISTINCT order_id) AS Total_Orders
FROM pizza_sales
GROUP BY DATENAME(WEEKDAY, order_date)
ORDER BY CASE DATENAME(WEEKDAY, order_date)
    WHEN 'Monday' THEN 1
    WHEN 'Tuesday' THEN 2
    WHEN 'Wednesday' THEN 3
    WHEN 'Thursday' THEN 4
    WHEN 'Friday' THEN 5
    WHEN 'Saturday' THEN 6
    WHEN 'Sunday' THEN 7
END;


-- 7. Monthly Trend for Total Orders
SELECT
    DATENAME(MONTH, order_date) AS Month_Name,
    COUNT(DISTINCT order_id) AS Total_Orders
FROM pizza_sales
GROUP BY
    MONTH(order_date),
    DATENAME(MONTH, order_date)
ORDER BY MONTH(order_date);


-- 8. Top 5 Months by Total Orders
SELECT TOP 5
    DATENAME(MONTH, order_date) AS Month_Name,
    COUNT(DISTINCT order_id) AS Total_Orders
FROM pizza_sales
GROUP BY DATENAME(MONTH, order_date)
ORDER BY Total_Orders DESC;


-- =========================================================
-- C. SALES MIX
-- =========================================================

-- 9. Percentage of Sales by Pizza Category
SELECT
    pizza_category,
    CAST(SUM(total_price) AS DECIMAL(12, 2)) AS Total_Revenue,
    CAST(
        SUM(total_price) * 100.0 / (SELECT SUM(total_price) FROM pizza_sales)
        AS DECIMAL(10, 2)
    ) AS Sales_Percentage
FROM pizza_sales
GROUP BY pizza_category
ORDER BY Total_Revenue DESC;


-- 10. Percentage of Sales by Pizza Size
SELECT
    pizza_size,
    CAST(SUM(total_price) AS DECIMAL(12, 2)) AS Total_Revenue,
    CAST(
        SUM(total_price) * 100.0 / (SELECT SUM(total_price) FROM pizza_sales)
        AS DECIMAL(10, 2)
    ) AS Sales_Percentage
FROM pizza_sales
GROUP BY pizza_size
ORDER BY Total_Revenue DESC;


-- 11. Total Pizzas Sold by Pizza Category
SELECT
    pizza_category,
    SUM(quantity) AS Total_Quantity_Sold
FROM pizza_sales
GROUP BY pizza_category
ORDER BY Total_Quantity_Sold DESC;


-- =========================================================
-- D. BEST / WORST SELLERS
-- =========================================================

-- 12. Top 5 Pizzas by Revenue
SELECT TOP 5
    pizza_name,
    CAST(SUM(total_price) AS DECIMAL(12, 2)) AS Total_Revenue
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Revenue DESC;


-- 13. Bottom 5 Pizzas by Revenue
SELECT TOP 5
    pizza_name,
    CAST(SUM(total_price) AS DECIMAL(12, 2)) AS Total_Revenue
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Revenue ASC;


-- 14. Top 5 Pizzas by Quantity
SELECT TOP 5
    pizza_name,
    SUM(quantity) AS Total_Pizzas_Sold
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Pizzas_Sold DESC;


-- 15. Bottom 5 Pizzas by Quantity
SELECT TOP 5
    pizza_name,
    SUM(quantity) AS Total_Pizzas_Sold
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Pizzas_Sold ASC;


-- 16. Top 5 Pizzas by Total Orders
SELECT TOP 5
    pizza_name,
    COUNT(DISTINCT order_id) AS Total_Orders
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Orders DESC;


-- 17. Bottom 5 Pizzas by Total Orders
SELECT TOP 5
    pizza_name,
    COUNT(DISTINCT order_id) AS Total_Orders
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Orders ASC;


/*
Optional filters can be applied with WHERE clauses, for example:

WHERE pizza_category = 'Classic'
WHERE pizza_size = 'L'
WHERE MONTH(order_date) = 2

Place the WHERE clause before GROUP BY.
*/
