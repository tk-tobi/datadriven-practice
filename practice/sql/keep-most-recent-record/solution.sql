SELECT
  user_id,
  username,
  email,
  signup_date
FROM (
  SELECT
    user_id,
    username,
    email,
    signup_date,
    ROW_NUMBER() OVER (PARTITION BY user_id ORDER BY signup_date DESC) AS rnk
  FROM users
)
WHERE rnk = 1
