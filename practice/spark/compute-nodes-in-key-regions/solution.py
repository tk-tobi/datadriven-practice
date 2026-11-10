from pyspark.sql import functions as F

nodes = spark.table("infra_nodes")
regions = ["eu-west-1", "eu-central-1"]

result = (
  nodes
    .filter((F.col("region") in regions) & (F.col("cpu_pct") > 70))
)
