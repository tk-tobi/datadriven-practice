from pyspark.sql import functions as F

flags = spark.table("feat_flags")

result = (
  flags
    .filter(F.col("enabled") != 1)
)
