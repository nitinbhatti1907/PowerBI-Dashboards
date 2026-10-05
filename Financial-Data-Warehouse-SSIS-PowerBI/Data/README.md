# Data Sources

The SSIS workflow uses three source types:

1. **SQL Server** — the main `financial_transactions_db` transactional source.
2. **Excel** — exchange-rate reference data.
3. **CSV** — supplier master data.

For easy GitHub inspection, the exchange-rate workbook is represented here as an equivalent CSV extract. The actual SSIS package was developed against `exchange_rates.xlsx`.

`Missing Supplier.csv` is an ETL exception/output file produced when supplier enrichment cannot find a valid match. In the validated run used for this portfolio project, no missing-supplier rows were required.
