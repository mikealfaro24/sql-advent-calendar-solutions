-- SQL Advent Calendar - Day 12
-- Title: North Pole Network Most Active Users
-- Difficulty: hard
--
-- Question:
-- The North Pole Network wants to see who's the most active in the holiday chat each day. Write a query to count how many messages each user sent, then find the most active user(s) each day. If multiple users tie for first place, return all of them.
--
-- The North Pole Network wants to see who's the most active in the holiday chat each day. Write a query to count how many messages each user sent, then find the most active user(s) each day. If multiple users tie for first place, return all of them.
--

-- Table Schema:
-- Table: npn_users
--   user_id: INT
--   user_name: VARCHAR
--
-- Table: npn_messages
--   message_id: INT
--   sender_id: INT
--   sent_at: TIMESTAMP
--

-- My Solution:

WITH user_message_counts AS (
    SELECT
        u.user_id,
        u.user_name,
        DATE(m.sent_at) AS day, -- full date, not just day number
        COUNT(*) AS user_count
    FROM npn_users u
    INNER JOIN npn_messages m
        ON u.user_id = m.sender_id
    GROUP BY u.user_id, u.user_name, DATE(m.sent_at)
),
user_ranked AS (
    SELECT
        *,
        COUNT(*) OVER (PARTITION BY day) AS day_count,
        RANK() OVER (PARTITION BY day ORDER BY user_count DESC) AS rank_in_day
    FROM user_message_counts
)
SELECT
    user_id,
    user_name,
    day,
    user_count,
    day_count,
    rank_in_day
FROM user_ranked
WHERE rank_in_day = 1
ORDER BY day;
