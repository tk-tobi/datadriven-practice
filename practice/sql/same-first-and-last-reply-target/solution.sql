-- SELECT * FROM chat_msgs ORDER BY sender_id;

WITH first_last_messages AS (
  SELECT
    sender_id,
    CAST(sent_at AS DATE) AS msg_date,
    FIRST_VALUE(reply_to) OVER (PARTITION BY sender_id, CAST(sent_at AS DATE) ORDER BY sent_at) AS first_recipient,
    LAST_VALUE(reply_to) OVER (PARTITION BY sender_id, CAST(sent_at AS DATE) ORDER BY sent_at) AS last_recipient
  FROM chat_msgs
  GROUP BY sender_id, JULIANDAY(sent_at)
)
  
SELECT 
  sender_id,
  first_recipient AS reply_to,
  msg_date
FROM first_last_messages
WHERE first_recipient = last_recipient
