from pyspark.sql import functions as F

items = spark.table("content_items")

result = (
  items
    .select("content_id", "title", "duration_seconds")
    .orderBy(F.col("duration_seconds").desc_nulls_last(), "content_id")
)
