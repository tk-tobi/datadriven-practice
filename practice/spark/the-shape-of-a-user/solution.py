from pyspark.sql import functions as F

data = spark.table("event_data")

# result = (data.show(8))
result = (
  data
    .groupBy(F.col("user_id"))
    .agg(
      F.count(F.when(F.col("event_type") == "search", 1)).alias("searches"),
      F.count(F.when(F.col("event_type") == "add_to_cart", 1)).alias("add_to_carts"),
      F.count(F.when(F.col("event_type") == "purchase", 1)).alias("purchases")
      )
)
