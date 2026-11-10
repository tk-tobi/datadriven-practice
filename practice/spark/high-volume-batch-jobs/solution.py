from pyspark.sql import functions as F

jobs = spark.table("batch_jobs")

result = (
  jobs
    .filter(F.col("rows_done") > 5000)
    .select("job_name", "priority", "rows_done")
    .orderBy(F.col("rows_done").desc())
)
