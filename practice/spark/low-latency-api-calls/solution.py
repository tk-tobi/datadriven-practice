from pyspark.sql import functions as F

calls = spark.table("api_calls")

result = (
  calls
    .filter(F.col("latency") <= 100)
    .orderBy(F.col("latency"), F.col("call_id"))
)
