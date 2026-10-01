from pyspark.sql.functions import col, to_date, lower, trim, sum as spark_sum, count, round
from notebookutils import mssparkutils

# ============================================================
# AZURE SYNAPSE RETAIL MEDALLION PIPELINE
# Bronze -> Silver -> Gold
# ============================================================

# ------------------------------------------------------------
# 1. BRONZE - Read Parquet data from ADLS Gen2
# ------------------------------------------------------------

bronze_path = (
    "abfss://retails@synapseprojectnb.dfs.core.windows.net/"
    "bronze/nitinbhatti1907/PowerBI-Dashboards/refs/heads/master/"
    "Azure-Synapse-Analytics/Data/retail_transactions_bronze.parquet"
)

df_bronze = spark.read.parquet(bronze_path)

print("Bronze data:")
df_bronze.show(10, truncate=False)
df_bronze.printSchema()


# ------------------------------------------------------------
# 2. SILVER - Filter purchases and clean data
# ------------------------------------------------------------

df_silver = (
    df_bronze
    .filter(col("event_type") == "purchase")
    .filter(
        col("customer_id").isNotNull()
        & (trim(col("customer_id")) != "")
        & col("amount").isNotNull()
    )
    .withColumn("event_date", to_date(col("event_timestamp")))
    .withColumn("payment_method", lower(trim(col("payment_method"))))
    .withColumn("amount", col("amount").cast("decimal(10,2)"))
    .select(
        "event_id",
        "customer_id",
        "event_timestamp",
        "event_date",
        "product_id",
        "product_category",
        "payment_method",
        "amount",
        "location"
    )
)

silver_path = (
    "abfss://retails@synapseprojectnb.dfs.core.windows.net/"
    "silver/retail_transactions/"
)

df_silver.write.mode("overwrite").parquet(silver_path)

print("Silver data:")
df_silver.show(10, truncate=False)
print("Silver row count:", df_silver.count())


# ------------------------------------------------------------
# 3. GOLD - Build one Power BI-ready analytics table
# ------------------------------------------------------------

df_gold = (
    df_silver
    .groupBy(
        "event_date",
        "customer_id",
        "product_id",
        "product_category",
        "payment_method",
        "location"
    )
    .agg(
        spark_sum("amount").alias("total_revenue"),
        count("*").alias("total_purchases")
    )
    .withColumn(
        "avg_purchase_value",
        round(col("total_revenue") / col("total_purchases"), 2)
    )
    .orderBy("event_date")
)

gold_folder = (
    "abfss://retails@synapseprojectnb.dfs.core.windows.net/gold/"
)

temp_path = gold_folder + "_temp_retail_analytics/"
final_file = gold_folder + "retail_analytics_gold.parquet"

# Spark normally writes Parquet as a folder of part files.
# Coalesce to one partition, then rename the part file so Power BI
# can consume one clearly named Gold Parquet file.
df_gold.coalesce(1).write.mode("overwrite").parquet(temp_path)

files = mssparkutils.fs.ls(temp_path)

part_file = [
    file.path
    for file in files
    if file.name.startswith("part-") and file.name.endswith(".parquet")
][0]

try:
    mssparkutils.fs.rm(final_file, False)
except:
    pass

mssparkutils.fs.mv(part_file, final_file, True, True)
mssparkutils.fs.rm(temp_path, True)

print("Gold data:")
df_gold.show(20, truncate=False)
print("Gold row count:", df_gold.count())
print("Gold file created at:", final_file)


# ------------------------------------------------------------
# 4. VERIFY GOLD OUTPUT
# ------------------------------------------------------------

df_gold_check = spark.read.parquet(final_file)

print("Verified Gold output:")
df_gold_check.show(20, truncate=False)
df_gold_check.printSchema()
