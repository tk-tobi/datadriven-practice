from pyspark.sql import functions as F

items = spark.table("content_items")

result = (
  items
    .filter(F.year(F.col("publish_date")) == 2026)
)
