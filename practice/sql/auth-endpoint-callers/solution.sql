WITH auth_calls AS (
  SELECT
    user_id,
    endpoint,
    call_id
  FROM api_calls
  WHERE endpoint LIKE '%auth%'
    AND user_id IS NOT NULL
)
 
SELECT
  a.user_id,
  u.username,
  u.email,
  a.call_id,
  a.endpoint
FROM auth_calls AS a
INNER JOIN users AS u
  ON a.user_id = u.user_id
ORDER BY 1;
 
-- SELECT * FROM auth_calls LIMIT 5;
