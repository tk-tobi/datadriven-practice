SELECT
  COUNT(DISTINCT owner_id) AS distinct_owners
FROM api_tokens
WHERE EXTRACT(YEAR FROM issued) = 2026
