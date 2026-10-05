# Power BI Report

## Model

Power BI consumes the warehouse reporting view:

`dbo.vw_financial_transactions_bi`

The semantic model contains:

- **FinancialTransactions**
- **Date**
- **Key Measures**

## Core Measures

```DAX
Total Transaction Value =
SUM(FinancialTransactions[amount_usd])

Total Transactions =
DISTINCTCOUNT(FinancialTransactions[transaction_id])

Total Customers =
DISTINCTCOUNT(FinancialTransactions[customer_id])

Average Transaction Value =
DIVIDE(
    [Total Transaction Value],
    [Total Transactions]
)

Total Suppliers =
DISTINCTCOUNT(FinancialTransactions[supplier_name])
```

## Final Dashboard

The one-page report contains:

- Total Transaction Value
- Total Transactions
- Total Customers
- Average Transaction Value
- Total Suppliers
- Monthly Transaction Value Trend
- Top 5 Customers by Transaction Value
- Transaction Value by Supplier
- Transaction Value by Source Currency
- Transaction Volume by Source Currency

### Slicers

- Date Range
- Currency
- Supplier
- Customer

## Validated Results

- **Total Transaction Value:** $5,611.41M
- **Total Transactions:** 1M
- **Total Customers:** 1K
- **Average Transaction Value:** $5.61K
- **Total Suppliers:** 3
