from pyspark.sql import functions as F

models = spark.table("ml_models")

# result = (
#   models
#     .filter((F.col("accuracy") >= 0.9) & (F.lower(F.col("status")) == 'deployed'))
#     .select("mdl_name")
#     .distinct()
#     .agg(F.count("*").alias("high_accuracy_deployed_models"))
# )

result = (
  models
    .filter((F.col("accuracy") >= 0.9) & (F.col("status") in ['deployed', 'Deployed']))
    .agg(F.countDistinct("mdl_name").alias("high_accuracy_deployed_models"))
)
