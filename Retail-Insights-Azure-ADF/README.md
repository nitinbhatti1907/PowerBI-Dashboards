# ☁️ Retail Insight Dashboard | Azure Data Factory + ADLS Gen2 + Power BI

An end-to-end cloud analytics portfolio project that moves retail source data through **Azure Data Lake Storage Gen2 (ADLS Gen2)** using an **Azure Data Factory (ADF)** pipeline and then connects the output layer to **Power BI** for transformation, modeling, DAX, and reporting.

![Retail Insight Dashboard](./Images/Home.png)

## 🎯 Project Objective

This project demonstrates a cloud-based BI workflow rather than loading local CSV files directly into Power BI.

```text
CSV Source Files
      ↓
ADLS Gen2 - input/
      ↓
Azure Data Factory Copy Pipeline
      ↓
ADLS Gen2 - output/
      ↓
Power BI / Power Query
      ↓
Data Model + DAX
      ↓
Retail Insight Dashboard
```

## 🛠️ Tech Stack

- **Azure Data Factory (ADF)**
- **Azure Data Lake Storage Gen2 (ADLS Gen2)**
- **Azure Storage / StorageV2**
- **Microsoft Azure**
- **Power BI Desktop**
- **Power Query**
- **DAX**
- **Data Modeling**
- **ETL / Data Pipelines**
- **Cloud Analytics**

## ☁️ Azure Architecture

- **Resource Group:** `ADF-RG`
- **Azure Data Factory:** `retail-insights-adf`
- **ADLS Gen2 Storage Account:** `retailanalyticsnb26`
- **Container:** `retail-sales`
- **Landing folder:** `input/`
- **Pipeline output folder:** `output/`

The ADF pipeline copies the three retail CSV files from the `input` folder to the `output` layer. Power BI connects to the output files, where report-specific transformations and modeling are performed.

> **Architecture note:** In this learning project, ADF demonstrates cloud ingestion and pipeline orchestration. The files are copied without major transformations inside ADF; data cleaning and shaping are completed in Power Query.

## 📊 Dataset

| File | Rows | Purpose |
|---|---:|---|
| `customers.csv` | **505** | Customer profile, geography, segment and status |
| `products.csv` | **202** | Product, category, subcategory, brand and pricing |
| `sales.csv` | **97,500** | Order-level sales, quantity, discounts and net sales |

## 🔄 Power BI Transformation & Modeling

After connecting Power BI to the ADLS Gen2 output layer:

- Promoted headers and assigned appropriate data types
- Standardized date, text, and numeric fields
- Prepared customer, product, and sales tables for analysis
- Created a dedicated Date table
- Built one-to-many relationships:
  - `Customers[CustomerID]` → `Sales[CustomerID]`
  - `Products[ProductID]` → `Sales[ProductID]`
- Created DAX measures for revenue, orders, customers, and average order value

## 📐 Core Measures

```DAX
Revenue = SUM(Sales[NetSales])

Total Orders = DISTINCTCOUNT(Sales[OrderID])

Total Customers = DISTINCTCOUNT(Sales[CustomerID])

Avg Order Value = DIVIDE([Revenue], [Total Orders])
```

## ❓ Business Questions

1. What is total revenue?
2. How many orders were placed?
3. How many customers purchased?
4. Which category and subcategory perform best?
5. Which cities contribute the most revenue?
6. Which customer segment drives more sales?
7. Which products generate the highest revenue?
8. How does revenue trend over time?

## 📈 Dashboard Features

- Revenue, Total Orders, Total Customers, and Average Order Value KPIs
- Revenue trend by date
- Category and subcategory performance
- Customer segment contribution
- Top cities by revenue
- Top products by revenue
- Year, month, and category slicers

## 💱 Currency Presentation

The underlying retail source data contains **INR-based monetary values**. For this portfolio dashboard, monetary fields are displayed with **USD ($) formatting** in Power BI.

**Important:** this is a reporting/display-format change; the numerical values were not recalculated using a live INR-to-USD exchange rate.

## 📁 Repository Structure

```text
Retail-Insights-Azure-ADF/
├── README.md
├── Data/
│   ├── customers.csv
│   ├── products.csv
│   └── sales.csv
├── Images/
│   └── Home.png
└── PowerBI/
    └── Sales Insight Dashboard.pbix
```

## 🚀 Skills Demonstrated

- Building a cloud ingestion workflow with **Azure Data Factory**
- Organizing input and output layers in **ADLS Gen2**
- Connecting Power BI to cloud-hosted data
- Data preparation using **Power Query**
- Dimensional data modeling and relationships
- Writing **DAX** measures
- Building an interactive business dashboard
- Translating retail data into decision-oriented insights
