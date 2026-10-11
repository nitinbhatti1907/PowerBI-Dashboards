# Amazon Athena

Athena queries the Parquet files stored under the S3 `orders_parquet_datalake/` prefix using metadata maintained by the AWS Glue Data Catalog.

## Configuration

- **Catalog:** `AwsDataCatalog`
- **Database:** `etl_pipeline`
- **Table:** `orders_parquet_datalake`
- **Workgroup:** `primary`
- **Region:** `us-east-2`
- **Query result location:** `s3://nitin-aws-etl/athena-results/`

See `validation_queries.sql` for KPI validation and the `$path` query used to diagnose duplicate Parquet outputs.
