# Source Data

`orders_etl.json` is the nested JSON sample used by the S3-triggered Lambda ETL pipeline.

## Source grain

The source contains **12 orders**. Each order contains:

- order-level attributes;
- one nested customer object;
- one or more nested product objects.

Flattening the nested product arrays creates **23 order-product rows**.

The addresses and `example.com` email addresses are sample/demo data used for the portfolio project.
