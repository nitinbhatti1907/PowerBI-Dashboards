# SSIS Implementation

## Project

- **Project:** `Retail_ETL_SSIS`
- **Package:** `FinancialTransactions.dtsx`
- **Deployment model:** Project Deployment Model
- **Catalog:** SSISDB
- **Environment:** `Dev`
- **SQL Server Agent job:** `FinancialDataWarehouse`

## Control Flow

The package prepares the warehouse and then loads the three logical data areas:

1. truncate/reload warehouse financial transactions;
2. truncate/reload exchange-rate reference data;
3. truncate/reload supplier reference data;
4. execute the exchange-rate data flow;
5. execute the supplier data flow;
6. execute the customer/financial transaction data flow.

## Data Flow: Exchange Rates

**Source:** Excel workbook  
**Destination:** SQL Server warehouse reference table

Main components:

- Excel Source
- Data Conversion
- OLE DB Destination

## Data Flow: Suppliers

**Source:** supplier CSV  
**Destination:** SQL Server warehouse supplier table

Main components:

- Flat File Source
- Data Conversion
- OLE DB Destination

## Data Flow: Customer / Financial Transactions

**Source:** `financial_transactions_db`

Main processing pattern:

```text
SQL Server Source
      ↓
Lookup Exchange Rates
   ↙          ↘
Match       No Match
   ↘          ↙
     Union All
        ↓
Create Amount USD
        ↓
Lookup Suppliers
        ↓
Split Null Suppliers
   ↙              ↘
Warehouse       Missing Supplier Output
```

## Deployment Configuration

The project was deployed to **SSISDB** and configured with a **Dev** environment. Environment variables are mapped to project parameters for server names and file locations.

The package was successfully executed through the **SQL Server Agent** job `FinancialDataWarehouse`.

A recurring schedule is intentionally not configured in this portfolio version.
