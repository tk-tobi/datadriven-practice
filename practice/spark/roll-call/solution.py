from pyspark.sql import functions as F

customers = spark.table("customers")

result = (
  customers
    .select(
      "first_name",
      "last_name",
      "country"
    )
    .orderBy("first_name", "last_name", "country")
  )
