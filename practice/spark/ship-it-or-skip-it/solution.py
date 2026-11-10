from pyspark.sql import functions as F

logs = spark.table("deploy_logs")

# logs.show(8)
result = (
  logs
    .groupBy(F.to_date(F.col("deploy_at")).alias("deploy_date"))
    .agg(F.count("*").alias("deploy_count"))
    .orderBy(F.col("deploy_date"))
  )
