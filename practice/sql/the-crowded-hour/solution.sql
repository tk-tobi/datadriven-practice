/*WITH session_start_end AS (
SELECT
  d.device_type,
  us.user_id,
  us.device_id,
  us.session_start,
  us.session_duration_sec,
  datetime(us.session_start, '+' || us.session_duration_sec || ' seconds') AS session_end
FROM user_sessions AS us
JOIN devices AS d
ON us.device_id = d.device_id
ORDER BY device_type, session_start
), events AS (
  SELECT
    device_type,
    session_start AS event_stamp,
    1 AS event_type
  FROM session_start_end
  
  UNION ALL
    
  SELECT
    device_type,
    session_end AS event_stamp,
    -1 AS event_type
  FROM session_start_end
), concurrent_users AS (
SELECT
  *,
  SUM(event_type) OVER (PARTITION BY device_type ORDER BY event_stamp) AS active_users,
  LEAD(event_stamp) OVER (PARTITION BY device_type ORDER BY event_stamp) AS next_window_close
FROM events
WHERE event_stamp IS NOT NULL
), ranked_windows AS (
  SELECT
    device_type,
    event_stamp || ' to ' || next_window_close AS time_period,
    active_users AS user_count,
    ROW_NUMBER() OVER (
      PARTITION BY device_type 
      ORDER BY active_users DESC, event_stamp ASC
    ) AS rnk
  FROM concurrent_users
  WHERE next_window_close IS NOT NULL 
    AND event_type = 1 -- Only look at windows where someone joined to hit the peak
)

SELECT
  device_type,
  time_period,
  user_count
FROM ranked_windows
WHERE rnk = 1;
*/

WITH session_windows AS (
  -- 1. Define the start and end of every session
  SELECT 
    d.device_type,
    us.user_id,
    us.session_start,
    datetime(us.session_start, '+' || us.session_duration_sec || ' seconds') AS session_end
  FROM user_sessions AS us
  JOIN devices AS d 
    ON us.device_id = d.device_id
), 
concurrent AS (
  -- 2. Self-Join to find overlaps and count DISTINCT users
  SELECT 
    sw1.device_type,
    sw1.session_start,
    sw1.session_end,
    COUNT(DISTINCT sw2.user_id) AS user_count
  FROM session_windows AS sw1
  INNER JOIN session_windows AS sw2
    ON sw1.device_type = sw2.device_type
    -- Overlap logic: Session 2 starts before Session 1 ends, AND Session 2 ends after Session 1 starts
    AND sw2.session_start <= sw1.session_end 
    AND sw2.session_end >= sw1.session_start
  GROUP BY 
    sw1.device_type, 
    sw1.session_start, 
    sw1.session_end
), 
ranked AS (
  -- 3. Rank them to find the absolute peak, with tie-breakers
  SELECT 
    device_type,
    session_start || ' to ' || session_end AS time_period,
    user_count,
    ROW_NUMBER() OVER (
      PARTITION BY device_type 
      ORDER BY user_count DESC, session_start ASC, session_end ASC
    ) AS rnk
  FROM concurrent
)

-- 4. Filter for the #1 ranked window per device
SELECT 
  device_type,
  time_period,
  user_count
FROM ranked
WHERE rnk = 1;
