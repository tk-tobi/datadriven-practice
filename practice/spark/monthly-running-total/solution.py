from pyspark.sql import functions as F
from pyspark.sql.window import Window

transactions = spark.table("transactions")

window_spec = (
  Window
    .partitionBy("product_id")
    .orderBy("month")
    .rowsBetween(Window.unboundedPreceding, Window.currentRow) 
)

result = (
  transactions
    .filter(F.col("product_id").isNotNull())
    .groupBy("product_id",
      F.date_format(F.col("transaction_date"), "yyyy-MM").alias("month"))
    .agg(F.sum("total_amount").alias("monthly_total"))
    .withColumn("cumulative_total", F.sum("monthly_total").over(window_spec))
)

# transactions.show(8)

# Hint
# Consider using F.date_trunc("yyyy-MM", F.col("transaction_date")) to handle the date formatting.
