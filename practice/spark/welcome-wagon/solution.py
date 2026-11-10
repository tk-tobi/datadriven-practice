from pyspark.sql import functions as F

users = spark.table("users")

# users.show(8)

# results = (
#   users
#     .filter(F.year(F.col("signup_date")) == 2025)
#     .agg(F.count("*").alias('signup_count'))
#   )
results = (
  users
    .filter("signup_date >= '2025-01-01' and signup_date < '2026-01-01'")
    .agg(F.count("*"))
  )
