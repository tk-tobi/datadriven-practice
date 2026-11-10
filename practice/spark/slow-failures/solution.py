from pyspark.sql import functions as F

calls = spark.table("api_calls")

result = (
  calls
    .filter((F.col("status") >= 400) & (F.col("latency") > 200))
    .select(
      "endpoint",
      "status",
      "latency",
      "err_msg"
    )
    .orderBy(F.col("latency").desc()) 
)
