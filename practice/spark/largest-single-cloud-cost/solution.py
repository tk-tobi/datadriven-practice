from pyspark.sql import functions as F

costs = spark.table("cloud_costs")

result = (
  costs
    .orderBy(F.col("amount").desc(), F.col("svc_name"))
    .show(1)
)
