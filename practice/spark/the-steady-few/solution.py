# -- SELECT * FROM svc_health LIMIT 10

# SELECT
#   region,
#   SUM(effective_hours) AS total_effective_hours
# FROM (
#   SELECT
#     region,
#     uptime - (COALESCE(latency, 0) * 0.1) AS effective_hours
#   FROM svc_health
#   WHERE uptime IS NOT NULL
# ) sub_table
# GROUP BY region
# ORDER BY total_effective_hours DESC
# LIMIT 3

# svc_health.createOrReplaceTempView("svc_health")

# 2. Run pure SQL using spark.sql()
result_df = spark.sql("""
SELECT
  region,
  SUM(effective_hours) AS total_effective_hours
FROM (
  SELECT
    region,
    uptime - (COALESCE(latency, 0) * 0.1) AS effective_hours
  FROM svc_health
  WHERE uptime IS NOT NULL
) sub_table
GROUP BY region
ORDER BY total_effective_hours DESC
LIMIT 3
""")
