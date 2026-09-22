from pyspark.sql import functions as F

result = (
  repo_commits
  .filter(F.col("message").isNotNull() & (F.length(F.trim(F.col("message"))) > 0))
  .groupBy(F.lower(F.col("author")).alias("author"))
  .agg(
    F.round(F.avg(F.length(F.col("message"))), 2).alias("avg_msg_len"),
    F.count("*").alias("commit_count"),
    F.round(F.avg(F.col("added")), 2).alias("avg_lines_added")
  )
  .filter(F.col("commit_count") > 2)
  .orderBy(F.col("avg_msg_len").desc(), F.col("author").asc())
)

'''
result = spark.sql("""
  SELECT 
    author,
    ROUND(AVG(LENGTH(message)), 2) AS avg_msg_len,
    COUNT(*) AS commit_count,
    ROUND(AVG(added), 2) AS avg_lines_added
  FROM repo_commits
  WHERE message IS NOT NULL 
    AND LENGTH(TRIM(message)) > 0
  GROUP BY author
  HAVING COUNT(*) > 2
  ORDER BY avg_msg_len DESC, author ASC
""")
'''
