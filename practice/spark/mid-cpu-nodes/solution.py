from pyspark.sql import functions as F

nodes = spark.table("infra_nodes")

result = (
  nodes
    .filter("cpu_pct BETWEEN 40 AND 80")
)
