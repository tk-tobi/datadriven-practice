WITH active_api_tokens AS (
  SELECT 
    issued
    --MAX(issued) AS newest_issue_date,
    --MIN(issued) AS oldest_issue_date 
  FROM api_tokens 
  --WHERE LOWER(status) = 'active'
    --AND (expires IS NULL OR expires >= DATE('now'))
  WHERE (expires IS NULL OR expires >= DATE('now'))
),
boundaries AS (
  SELECT
    MIN(issued) AS first_issued,
    MAX(issued) AS last_issued
  FROM active_api_tokens
)

SELECT
  JULIANDAY(last_issued) - JULIANDAY(first_issued) AS day_spread,
  (SELECT COUNT(*) FROM active_api_tokens WHERE issued = first_issued) AS tokens_at_earliest,
  (SELECT COUNT(*) FROM active_api_tokens WHERE issued = last_issued) AS tokens_at_latest
FROM boundaries;


-- SELECT JULIANDAY(MAX(issued)) - JULIANDAY(MIN(issued)) FROM active_api_tokens;


-- SELECT * FROM api_tokens LIMIT 5;
