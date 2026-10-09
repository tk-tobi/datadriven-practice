SELECT 
  DISTINCT username
FROM users u
JOIN search_queries s
  ON u.user_id = s.user_id
JOIN page_views p
  ON u.user_id = p.user_id
JOIN transactions t
  ON u.user_id = t.user_id
-- LIMIT 10;
