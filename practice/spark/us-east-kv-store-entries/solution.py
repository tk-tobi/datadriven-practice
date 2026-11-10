from pyspark.sql import functions as F

store = spark.table("kv_store")

result = (
  store
    .filter(F.col("region") == "us-east-1")
    .select("entry_id", "kv_key", "kv_value", "ttl_secs", "region", "created", "expires")
)
