from pyspark.sql import functions as F

# models = spark.table("ml_models")

ml_models = spark.table("ml_models")

# accuracy is stored 0..1; the band is stated in percent
elite_models = ml_models.filter((F.col("accuracy") * 100).between(91, 100))

result = elite_models.agg(F.avg("accuracy").alias("avg_accuracy"))
