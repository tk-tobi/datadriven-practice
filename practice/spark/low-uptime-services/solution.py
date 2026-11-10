from pyspark.sql import functions as F

svcs = spark.table("svc_health")

result = (
  svcs
    .filter(F.col("uptime") < 95.0)
    .select(
      "svc_name",
      "checked",
      "uptime"
    )
    .orderBy("uptime", "checked")
)
