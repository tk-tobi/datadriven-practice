from pyspark.sql import functions as F

logs = spark.table("deploy_logs")

result = (
  logs
    .filter((F.col("env_name") == 'production') & (F.col("dur_secs") > 150))
    .select("svc_name", "version", "dur_secs", "deploy_at")
    .orderBy(F.col("dur_secs").desc())  
)

# logs.show(8)
