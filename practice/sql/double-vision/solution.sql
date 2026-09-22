SELECT
  email,
  COUNT(*) AS occurence_count,
  MIN(signup_date) AS earliest_signup,
  MAX(signup_date) AS latest_signup
FROM users
WHERE email is NOT NULL
GROUP BY email
HAVING COUNT(*) > 1 
ORDER BY COUNT(*) DESC, email;
