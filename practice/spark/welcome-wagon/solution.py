from pyspark.sql import functions as F

users = spark.table("users")

# users.show(8)

results = (
  users
    .filter(F.year(F.col("signup_date")) == 2025)
    .agg(F.count("*").alias('signup_count'))
  )
