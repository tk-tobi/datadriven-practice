from pyspark.sql import functions as F

# infra = spark.table("infra_nodes")

result = (
  infra_nodes
    .select("node_id", "hostname", "cpu_pct")
    .orderBy(F.col("cpu_pct").desc())
    .show(10)
)
