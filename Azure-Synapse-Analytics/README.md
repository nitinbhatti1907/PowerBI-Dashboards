# 🏗️ Retail Transaction Analytics | Azure Synapse + PySpark + Power BI

An end-to-end **Azure analytics / medallion architecture project** that starts with retail event data in GitHub, processes it through **Bronze, Silver, and Gold layers in Azure Synapse Analytics using PySpark**, and delivers a business-facing **Power BI dashboard** from the Gold layer.

![Retail Transaction Analytics Dashboard](./Images/Home.png)

## 🎯 Project Objective

The goal was to build a practical cloud analytics workflow rather than connecting Power BI directly to a flat source file.

```text
GitHub JSON Source
        ↓
Azure / ADLS Gen2
        ↓
Bronze Layer
Raw transaction events
        ↓
Azure Synapse + PySpark
        ↓
Silver Layer
Clean purchase-level data
        ↓
Gold Layer
Power BI-ready analytics table
        ↓
Power BI
Retail Transaction Analytics Dashboard
```

---

## 🛠️ Tech Stack

- **Azure Synapse Analytics**
- **Apache Spark / PySpark**
- **Azure Data Lake Storage Gen2 (ADLS Gen2)**
- **Parquet**
- **Power BI Desktop**
- **DAX**
- **GitHub**
- **Medallion Architecture**
- **Data Cleaning & Transformation**
- **Business Intelligence**

---

## 📦 Source Dataset

The source file is:

```text
Data/retail_transactions_bronze.json
```

It contains **120 retail transaction events** with fields including:

- `event_id`
- `event_type`
- `customer_id`
- `event_timestamp`
- `payment_method`
- `product_id`
- `product_category`
- `amount`
- `location`
- `status`

The event stream includes **purchases, refunds, and cancellations**, along with deliberately imperfect records such as blank customer IDs so that data-quality logic can be demonstrated.

---

## 🥉 Bronze Layer

The Bronze layer preserves the source-oriented transaction events with minimal business transformation.

The source data is landed in Azure storage and read by Synapse Spark from the Bronze Parquet path.

**Purpose:**

- Preserve raw/source-oriented data
- Retain the complete event stream
- Provide a reproducible starting point for downstream processing

---

## 🥈 Silver Layer

The Silver layer creates a clean, analytics-ready purchase dataset.

### Transformations performed

- Keeps only `purchase` events
- Removes null customer IDs
- Removes blank/whitespace customer IDs
- Removes records with missing amounts
- Creates `event_date` from the original timestamp
- Standardizes payment methods to lowercase
- Casts monetary values to `decimal(10,2)`
- Retains both `event_timestamp` and `event_date`
- Writes the cleaned output as **Parquet**

### Silver columns

```text
event_id
customer_id
event_timestamp
event_date
product_id
product_category
payment_method
amount
location
```

---

## 🥇 Gold Layer

The Gold layer is designed specifically for BI consumption.

Instead of creating multiple disconnected summary tables, the project creates **one universal Power BI-ready Gold table** grouped by:

```text
event_date
customer_id
product_id
product_category
payment_method
location
```

and produces:

```text
total_revenue
total_purchases
avg_purchase_value
```

The final Gold output is:

```text
gold/retail_analytics_gold.parquet
```

This single table supports time, customer, product, category, payment-method, and location analysis in Power BI.

---

## ⚙️ PySpark Pipeline

The complete Bronze → Silver → Gold code is available here:

**[View PySpark pipeline](./Notebooks/retail_medallion_pipeline.py)**

A key data-quality improvement in the Silver layer is explicitly checking both null and blank customer IDs:

```python
.filter(
    col("customer_id").isNotNull()
    & (trim(col("customer_id")) != "")
    & col("amount").isNotNull()
)
```

This avoids treating empty strings as valid customer identifiers.

---

## 📊 Power BI Dashboard

The final dashboard presents purchase performance using the Gold analytics table.

### KPI Cards

- **Total Revenue:** $10.86K
- **Total Purchases:** 38
- **Average Purchase Value:** $285.69
- **Total Customers:** 18

### Dashboard Visuals

- **Daily Revenue Trend**
- **Top 10 Customers by Revenue**
- **Revenue by Location**
- **Revenue by Payment Method**
- **Revenue by Product Category**

### Interactive Filters

- Date range
- Product category
- Location
- Payment method
- Reset Filters bookmark button

---

## 📈 Key Insights

- **Chennai** generated the highest location revenue at approximately **$4.4K**, followed by **Kolkata** at about **$3.8K**.
- **Groceries** was the highest-revenue product category at approximately **$3.1K**, followed closely by **Electronics** at about **$2.9K**.
- **Cash** contributed the largest payment-method share at about **28.5%** of purchase revenue.
- Customer **C12** generated the highest customer revenue at approximately **$1.37K**, followed by **C16** at approximately **$1.24K**.
- Daily revenue shows substantial day-to-day variation, with multiple days exceeding **$1K**.

---

## 📐 Power BI Measures

```DAX
Total Revenue =
SUM(Gold_Retail_Analytics[total_revenue])

Total Purchases =
SUM(Gold_Retail_Analytics[total_purchases])

Average Purchase Value =
DIVIDE(
    [Total Revenue],
    [Total Purchases]
)

Total Customers =
DISTINCTCOUNT(Gold_Retail_Analytics[customer_id])
```

---

## 📁 Repository Structure

```text
Azure-Synapse-Analytics/
├── README.md
├── Data/
│   └── retail_transactions_bronze.json
├── Notebooks/
│   └── retail_medallion_pipeline.py
├── Images/
│   └── Home.png
└── PowerBI/
    └── Retail_Transaction_Analytics.pbix
```

---

## 🚀 Skills Demonstrated

- Designing a **Bronze / Silver / Gold medallion architecture**
- Processing cloud data using **Azure Synapse Spark**
- Writing practical **PySpark transformations**
- Implementing data-quality checks
- Working with **ADLS Gen2 and Parquet**
- Creating a BI-ready Gold data layer
- Writing **DAX measures**
- Designing an interactive **Power BI dashboard**
- Building slicers and bookmark-driven reset functionality
- Translating engineered data into business-facing insights
