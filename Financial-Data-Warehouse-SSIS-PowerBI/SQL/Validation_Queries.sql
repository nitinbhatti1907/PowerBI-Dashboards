USE financial_data_warehouse;
GO

-- Overall dashboard KPIs
SELECT
    SUM(CAST(amount_USD AS DECIMAL(18,2))) AS total_transaction_value_usd,
    COUNT(DISTINCT transaction_id) AS total_transactions,
    COUNT(DISTINCT customer_id) AS total_customers,
    CAST(
        SUM(CAST(amount_USD AS DECIMAL(18,2)))
        / NULLIF(COUNT(DISTINCT transaction_id), 0)
        AS DECIMAL(18,2)
    ) AS average_transaction_value_usd,
    COUNT(DISTINCT supplier_name) AS total_suppliers
FROM dbo.financial_transactions_staging;
GO

-- Monthly transaction-value trend
SELECT
    DATEFROMPARTS(YEAR(transaction_date), MONTH(transaction_date), 1) AS month_start,
    SUM(CAST(amount_USD AS DECIMAL(18,2))) AS transaction_value_usd
FROM dbo.financial_transactions_staging
GROUP BY DATEFROMPARTS(YEAR(transaction_date), MONTH(transaction_date), 1)
ORDER BY month_start;
GO

-- Top 5 customers by transaction value
SELECT TOP (5)
    customer_id,
    customer_name,
    SUM(CAST(amount_USD AS DECIMAL(18,2))) AS transaction_value_usd
FROM dbo.financial_transactions_staging
GROUP BY customer_id, customer_name
ORDER BY transaction_value_usd DESC;
GO

-- Supplier contribution
SELECT
    supplier_name,
    SUM(CAST(amount_USD AS DECIMAL(18,2))) AS transaction_value_usd,
    COUNT(DISTINCT transaction_id) AS transaction_count
FROM dbo.financial_transactions_staging
GROUP BY supplier_name
ORDER BY transaction_value_usd DESC;
GO

-- Source-currency mix
SELECT
    currency AS source_currency,
    SUM(CAST(amount_USD AS DECIMAL(18,2))) AS transaction_value_usd,
    COUNT(DISTINCT transaction_id) AS transaction_count
FROM dbo.financial_transactions_staging
GROUP BY currency
ORDER BY transaction_value_usd DESC;
GO
