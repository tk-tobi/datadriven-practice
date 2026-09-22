/*
dirty HTTP method 

AVG(latency)
FROM sub_table:
  RANK() OVER (ORDER latency ASC NULLS LAST) <= 5 AS rnk
  GROUP BY UPPER(method)
ORDER BY rnk DESC
*/
SELECT
  method,
  ROUND(AVG(latency), 2) AS slowest_five_avg
FROM (
  SELECT
    UPPER(method) AS method,
    latency,
    ROW_NUMBER() OVER (PARTITION BY UPPER(method) ORDER BY latency DESC NULLS LAST) AS rnk
  FROM api_calls
) sub_table
WHERE rnk <= 5
GROUP BY method
ORDER BY 2 DESC
-- LIMIT 5;
