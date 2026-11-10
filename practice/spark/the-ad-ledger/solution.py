from pyspark.sql import functions as F

imp = spark.table("ad_impressions")

result = (
  imp
    .filter("impression_time >= '2024-04-01' AND impression_time < '2024-07-01'")
    .agg(F.sum("revenue").alias('total_revenue'))
)
# imp.show(8)
