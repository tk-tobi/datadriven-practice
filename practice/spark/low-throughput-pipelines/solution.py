from pyspark.sql import functions as F

pipes = spark.table("data_pipes")

result = (
  pipes
    .filter(F.col("rows_out") < 2000)
    .select("pipe_name", "rows_out")
    .orderBy(F.col("rows_out").desc())
)
