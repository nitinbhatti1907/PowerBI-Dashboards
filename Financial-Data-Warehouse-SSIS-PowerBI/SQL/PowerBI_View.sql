USE financial_data_warehouse;
GO

CREATE OR ALTER VIEW dbo.vw_financial_transactions_bi
AS
SELECT
    transaction_id,
    customer_id,
    customer_name,
    cutomer_email AS customer_email,
    customer_phone,
    supplier_name,
    supplier_contact_name,
    supplier_phone,
    transaction_date,
    amount AS amount_local,
    currency AS source_currency,
    CAST(amount_USD AS DECIMAL(18,2)) AS amount_usd
FROM dbo.financial_transactions_staging;
GO

SELECT TOP (20) *
FROM dbo.vw_financial_transactions_bi;
GO
