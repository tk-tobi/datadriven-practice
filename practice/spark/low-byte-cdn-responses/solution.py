from pyspark.sql import functions as F

logs = spark.table("cdn_logs")

result = (
  logs
    .filter(F.col("bytes") < 5000)
    .orderBy("bytes")
)
