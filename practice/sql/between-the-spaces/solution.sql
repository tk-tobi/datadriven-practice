SELECT
  msg_id,
  ARRAY_SIZE(SPLIT(content, ' ')) AS word_count
  -- SPLIT(content, ' ')
FROM chat_msgs
