from pyspark.sql import functions as F

flags = spark.table("feat_flags")
sessions = spark.table("user_sessions")

flag_sessions = (
  flags.join(
    sessions,
    (F.to_date(sessions["session_start"]) >= F.to_date(flags["created"]))
    & (
      F.to_date(sessions["session_start"])
      < F.date_add(F.to_date(flags["created"]), 30)
    ),
    how="left",
  )
  .groupBy(
    flags["flag_id"],
    flags["flag_name"],
    flags["enabled"],
  )
  .agg(
    F.count(sessions["session_id"]).alias("launch_window_sessions")
  )
  .orderBy("flag_name", "flag_id")
  .select(
    F.col("flag_name"),
    F.regexp_replace(F.col("flag_name"), "_", " ").alias("display_name"),
    F.col("enabled"),
    F.col("launch_window_sessions"),
  )
)

flag_sessions.show()
