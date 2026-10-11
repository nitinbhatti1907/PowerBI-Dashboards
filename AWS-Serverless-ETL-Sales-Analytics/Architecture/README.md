# Architecture

```mermaid
flowchart LR
    A[orders_etl.json] --> B[(S3: orders_json_incoming)]
    B -->|Object-created event| C[Lambda: aws_etl_pipeline]
    C --> D[Flatten nested orders/products]
    D --> E[PyArrow Parquet]
    E --> F[(S3: orders_parquet_datalake)]
    C --> G[Glue Crawler: etl_pipeline_crawler]
    G --> H[(Glue Data Catalog: etl_pipeline)]
    H --> I[Athena]
    F --> I
    I --> J[Power BI via ODBC]
```

## S3 layout

```text
nitin-aws-etl/
├── orders_json_incoming/
├── orders_parquet_datalake/
└── athena-results/
```

The design separates incoming raw data, analytics-ready Parquet data, and Athena query-result files so non-Parquet query artifacts are never mixed into the Athena table location.
