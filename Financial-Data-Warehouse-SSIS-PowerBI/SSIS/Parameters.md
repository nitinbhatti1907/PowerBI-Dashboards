# SSIS Project Parameters

| Parameter | Example / Purpose |
|---|---|
| `Financial_transactions_db_ServerName` | `localhost` — source database server |
| `Financial_data_warehouse_ServerName` | `localhost` — warehouse database server |
| `CSVSuppliers_ConnectionString` | path to `suppliers.csv` |
| `ExcelExchangeRates_ExcelFilePath` | path to `exchange_rates.xlsx` |
| `MissingSupplier_ConnectionString` | output path for missing-supplier records |

## Environment Mapping

The SSISDB **Dev** environment contains matching environment variables:

- `EV_CSVSuppliers_ConnectionString`
- `EV_ExcelExchangeRates_ExcelFilePath`
- `EV_Financial_data_warehouse_ServerName`
- `EV_Financial_transactions_db_ServerName`
- `EV_MissingSupplier_ConnectionString`

These environment variables are referenced by the deployed project parameters so file paths and server names can be changed without editing the package.
