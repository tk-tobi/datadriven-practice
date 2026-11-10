from pyspark.sql import functions as F

pipes = spark.table("data_pipes")

result = (
  pipes
    .orderBy(F.col("dur_secs").desc())
    .select("pipe_name")
    .offset(1)
    .show(1)
)
