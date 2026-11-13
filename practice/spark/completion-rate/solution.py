from pyspark.sql import functions as F

orders = spark.table("orders")

result = (
  orders
  .filter(F.col("region").isNotNull())
  .groupBy("region")
  .agg(
    F.round(
      F.avg(F.when(F.col("status") == "Completed", 100.0).otherwise(0.0)),
      2
    ).alias("completion_pct")
  )
  .orderBy(F.col("region").asc())
)
