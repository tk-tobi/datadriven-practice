/* Check */
-- SELECT * FROM page_views;
-- SELECT * FROM chat_msgs;

WITH contact_list AS (
SELECT
  cm1.channel AS channel,
  cm1.sender_id AS user,
  cm2.sender_id AS contact
FROM chat_msgs AS cm1
JOIN chat_msgs AS cm2
  ON cm1.channel = cm2.channel
  AND cm1.sender_id != cm2.sender_id
), contact_views AS (
  SELECT
    c.channel,
    c.user,
    c.contact,
    p.page_url AS contact_page
  FROM contact_list AS c
  JOIN page_views AS p
    ON c.contact = p.user_id
)
SELECT DISTINCT
 user, contact_page 
FROM contact_views
WHERE contact_page NOT IN (
    SELECT page_url 
    FROM page_views 
    WHERE user_id = contact_views.user
)
  
