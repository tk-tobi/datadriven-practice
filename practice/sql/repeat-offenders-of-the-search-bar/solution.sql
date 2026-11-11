SELECT
  COUNT(*) AS repeat_searcher_count
FROM (
  SELECT
    COUNT(*) AS repeat_search_count
  FROM search_queries
  WHERE EXTRACT(YEAR FROM query_time) = 2026
  GROUP BY user_id
  HAVING COUNT(*) > 1
) sub_table
