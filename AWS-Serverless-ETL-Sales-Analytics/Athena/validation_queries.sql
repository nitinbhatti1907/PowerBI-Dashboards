-- AWS Serverless ETL Sales Analytics
-- Glue database: etl_pipeline
-- Athena table: orders_parquet_datalake

-- Preview the flattened Parquet data.
SELECT *
FROM "etl_pipeline"."orders_parquet_datalake"
LIMIT 10;


-- Validate row count after keeping one current Parquet output.
SELECT COUNT(*) AS flattened_rows
FROM "etl_pipeline"."orders_parquet_datalake";
-- Expected: 23


-- Validate business entities.
SELECT
    COUNT(DISTINCT order_id) AS total_orders,
    COUNT(DISTINCT customer_id) AS total_customers
FROM "etl_pipeline"."orders_parquet_datalake";
-- Expected: 12 orders, 9 customers


-- Calculate product-line revenue.
SELECT
    SUM(price * quantity) AS total_revenue
FROM "etl_pipeline"."orders_parquet_datalake";
-- Expected: 1665.00


-- Revenue by category.
SELECT
    category,
    SUM(price * quantity) AS revenue
FROM "etl_pipeline"."orders_parquet_datalake"
GROUP BY category
ORDER BY revenue DESC;


-- Top products by product-line revenue.
SELECT
    product_name,
    SUM(price * quantity) AS revenue
FROM "etl_pipeline"."orders_parquet_datalake"
GROUP BY product_name
ORDER BY revenue DESC
LIMIT 5;


-- Identify every physical Parquet file contributing rows to the table.
-- Useful for diagnosing duplicate files in an S3 table prefix.
SELECT
    "$path" AS file_path,
    COUNT(*) AS row_count
FROM "etl_pipeline"."orders_parquet_datalake"
GROUP BY "$path"
ORDER BY file_path;
