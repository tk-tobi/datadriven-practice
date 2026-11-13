from pyspark.sql import functions as F

nodes = spark.table("infra_nodes")

regions = ["us-east-1", "us-west-2", "eu-west-1"]

results = (
  nodes
    .filter(F.col("region").isin(regions))
)
