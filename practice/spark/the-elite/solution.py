from pyspark.sql import functions as F

models = spark.table("ml_models")

result = (
  models
    .filter(F.col("accuracy") >= 0.91)
    .agg(F.avg("accuracy").alias("avg_accuracy"))
)
