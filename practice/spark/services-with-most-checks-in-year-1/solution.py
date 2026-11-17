from pyspark.sql import functions as F
from pyspark.sql.window import Window

svc = spark.table("svc_health")
w = Window.partitionBy("svc_name").orderBy(F.col("check_count").desc())

result = (
  svc
    .filter((F.col("status") != 'healthy') & (F.col("status") != 'Healthy'))
    .groupBy("svc_name", F.year("checked").alias("check_year"))
    .agg(F.count("*").alias("check_count"), F.date_format(F.max("checked"), "yyyy-MM"))
    .withColumn("rnk", F.rank().over(w))
    .filter(F.col("rnk") == 1)
    .drop("rnk")
    .orderBy("svc_name", "check_year")
)
