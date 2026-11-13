from pyspark.sql import functions as F

content = spark.table("content_items")

# content.show(8)

result = (
  content
    .filter(F.col("creator_id") < 300)
    .select("content_type")
    .distinct() 
)
