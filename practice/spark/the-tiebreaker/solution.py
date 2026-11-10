from pyspark.sql import functions as F

users = spark.table("users")

result = (
  users
    .orderBy("account_status", F.col("age_bucket").desc_nulls_last())
)
