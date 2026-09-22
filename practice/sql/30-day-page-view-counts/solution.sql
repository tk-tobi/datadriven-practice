SELECT 
  user_id,
  COUNT(*) AS page_view_count
FROM page_views
WHERE viewed_at::DATE BETWEEN DATE('2026-12-28' ,'-30 days') AND '2026-12-28'
GROUP BY user_id;
