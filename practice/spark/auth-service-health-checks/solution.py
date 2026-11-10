from pyspark.sql import functions as F

svcs = spark.table("svc_health")

result = (
  svcs
    .filter(F.col("svc_name") == "auth-svc")
)
