# Power BI

The Power BI report connects to Amazon Athena through the **Amazon Athena ODBC 2.x driver**.

## Connection

- Region: `us-east-2`
- Catalog: `AwsDataCatalog`
- Database: `etl_pipeline`
- Workgroup: `primary`
- Athena results: `s3://nitin-aws-etl/athena-results/`

The final generic ODBC connection explicitly supplied the required AWS region and Athena output location.

## Power Query

A product-line revenue column is created as:

```powerquery
[price] * [quantity]
```

Column name: `line_amount`

## Measures

```DAX
Total Revenue =
SUM(orders_parquet_datalake[line_amount])

Total Orders =
DISTINCTCOUNT(orders_parquet_datalake[order_id])

Total Customers =
DISTINCTCOUNT(orders_parquet_datalake[customer_id])

Average Order Value =
DIVIDE([Total Revenue], [Total Orders])

Total Units Sold =
SUM(orders_parquet_datalake[quantity])
```

## Dashboard

The one-page report includes:

- Total Revenue
- Total Orders
- Total Customers
- Average Order Value
- Revenue Trend Over Time
- Revenue by Category
- Units Sold by Category
- Top 5 Products by Revenue
- Top 5 Customers by Revenue
- Date, Category, and Product slicers

The PBIX file is included as [`AWS Sales Analytics Dashboard.pbix`](./AWS%20Sales%20Analytics%20Dashboard.pbix).
