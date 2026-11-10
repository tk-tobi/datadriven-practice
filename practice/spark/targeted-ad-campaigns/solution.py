from pyspark.sql import functions as F

imp = spark.table("ad_impressions")

campaigns = ["RETARGETING_CART", "BRAND_AWARENESS_Q1"]
result = (
  imp
    .filter((F.col("clicked") == 1) & (F.col("ad_campaign") in campaigns))
)
