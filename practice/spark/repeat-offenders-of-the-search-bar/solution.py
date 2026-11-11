# SELECT
#   COUNT(*) AS repeat_searcher_count
# FROM (
#   SELECT
#     COUNT(*) AS repeat_search_count
#   FROM search_queries
#   WHERE EXTRACT(YEAR FROM query_time) = 2026
#   GROUP BY user_id
#   HAVING COUNT(*) > 1
# ) AS sub_table

from pyspark.sql import functions as F

table = spark.table("search_queries")

result = (
  table
    .filter(F.date_format(F.col("query_time"), 'yyyy') == '2026')
    .groupBy("user_id")
    .agg(F.count("*").alias("search_count"))
    .filter(F.col("search_count") > 1)
    .agg(F.count("*").alias("repeat_searcher_count"))
)
