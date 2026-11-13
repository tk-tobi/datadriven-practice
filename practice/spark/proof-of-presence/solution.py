from pyspark.sql import functions as F

df = spark.table("push_notifs_2fa")

result = (
  df.filter(F.lower(F.col("status")) == "delivered")
  .groupBy("platform")
  .agg(
    F.round(
      F.sum(F.when(F.col("opened") == True, 1).otherwise(0)) / F.count("*"),
      2
    ).alias("confirmation_rate"),
    F.round(
      F.sum(F.when(F.col("opened") == False, 1).otherwise(0)) / F.count("*"),
      2
    ).alias("ignored_rate")
  )
  .orderBy(F.col("confirmation_rate").desc())
)
