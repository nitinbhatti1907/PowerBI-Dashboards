import json
import boto3
import pandas as pd
import io
from datetime import datetime


def flatten(data):
    orders_data = []

    for order in data:
        for product in order["products"]:
            row_orders = {
                "order_id": order["order_id"],
                "order_date": order["order_date"],
                "total_amount": order["total_amount"],
                "customer_id": order["customer"]["customer_id"],
                "customer_name": order["customer"]["name"],
                "email": order["customer"]["email"],
                "address": order["customer"]["address"],
                "product_id": product["product_id"],
                "product_name": product["name"],
                "category": product["category"],
                "price": product["price"],
                "quantity": product["quantity"],
            }

            orders_data.append(row_orders)

    return pd.DataFrame(orders_data)


def lambda_handler(event, context):
    bucket_name = event["Records"][0]["s3"]["bucket"]["name"]
    key = event["Records"][0]["s3"]["object"]["key"]

    s3 = boto3.client("s3")
    response = s3.get_object(Bucket=bucket_name, Key=key)

    # Read and parse the nested JSON source.
    content = response["Body"].read().decode("utf-8")
    data = json.loads(content)
    df = flatten(data)

    # Build the Parquet output in memory instead of writing to local disk.
    parquet_buffer = io.BytesIO()
    df.to_parquet(parquet_buffer, index=False, engine="pyarrow")

    timestamp = datetime.now().strftime("%Y%m%d_%H%M%S")
    key_staging = f"orders_parquet_datalake/orders_ETL_{timestamp}.parquet"

    s3.put_object(
        Bucket=bucket_name,
        Key=key_staging,
        Body=parquet_buffer.getvalue(),
    )

    crawler_name = "etl_pipeline_crawler"
    glue = boto3.client("glue")
    glue.start_crawler(Name=crawler_name)
