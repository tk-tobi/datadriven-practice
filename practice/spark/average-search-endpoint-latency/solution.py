from pyspark.sql import functions as F

calls = spark.table("api_calls")

result = (
  calls
    .filter(F.col("endpoint") == "/api/v1/search")
    .agg(F.avg("latency").alias("avg_latency"))
)
