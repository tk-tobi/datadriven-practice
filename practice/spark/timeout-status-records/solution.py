from pyspark.sql import functions as F

svc = spark.table("svc_health")

result = (
  svc
    .filter(F.col("status") == "timeout")  
)
