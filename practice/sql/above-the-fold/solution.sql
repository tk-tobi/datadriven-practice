SELECT
  query_id,
  CASE
    WHEN clicked_result = 0 THEN 1
    WHEN clicked_result = 1
    AND results_count > 3 THEN 2
    WHEN clicked_result = 1
    AND results_count <= 3 THEN 3
  END AS rating
FROM search_queries
