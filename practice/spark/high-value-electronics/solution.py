from pyspark.sql import functions as F

products = spark.table("products")

result = (
  products
    .filter((F.col("in_stock") == 1) & (F.col("category") == 'Electronics'))
    .select(
      "product_name",
      "price"
    )
    .orderBy(F.col("price").desc())
    .show(5)
)
