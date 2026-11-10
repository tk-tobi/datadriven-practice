from pyspark.sql import functions as F

models = spark.table("ml_models")

result = (
  models
    .filter(F.col("accuracy") >= 0.90)
    .orderBy(F.col("accuracy").desc())
)
