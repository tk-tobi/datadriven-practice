from pyspark.sql import functions as f

tokens = spark.table("api_tokens")

# tokens.show(8)

result = (
  tokens
    .filter((F.col("scope") == 'read') & (F.col("requests") == 0))
    .agg(F.count("*").alias("unused_read_tokens"))
)
