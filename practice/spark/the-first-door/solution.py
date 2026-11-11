# -- SELECT DISTINCT
# --   user_id,
# --   FIRST_VALUE(event_name) OVER (PARTITION BY user_id ORDER BY event_ts) AS first_event
# -- FROM app_event_deliveries
# -- WHERE user_id IS NOT NULL
# -- -- LIMIT 10;
from pyspark.sql import functions as F
from pyspark.window import Window

delivery_df = spark.table("app_event_deliveries")

dedup_delivery = (
  delivery_df
    .filter(F.col("user_id").isNotNull())
    .groupBy("user_id")
    .agg(F.min("event_ts").alias("event_ts"))
    # .select("user_id", "earliest_event")  
)

result = (
  delivery_df
    .join(dedup_delivery, on=["user_id", "event_ts"])
    .select("user_id", F.col("event_name").alias("first_event"))
    .distinct()
    .orderBy("user_id")
)
