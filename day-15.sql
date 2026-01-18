-- SQL Advent Calendar - Day 15
-- Title: The Grinch's Mischief Tracker
-- Difficulty: hard
--
-- Question:
-- The Grinch is tracking his daily mischief scores to see how his behavior changes over time. Can you find how many points his score increased or decreased each day compared to the previous day?
--
-- The Grinch is tracking his daily mischief scores to see how his behavior changes over time. Can you find how many points his score increased or decreased each day compared to the previous day?
--

-- Table Schema:
-- Table: grinch_mischief_log
--   log_date: DATE
--   mischief_score: INTEGER
--

-- My Solution:

select 
  *,
  mischief_score - prev_score as diff
from (
select 
  log_date,
  mischief_score,
  lag(log_date) over(order by log_date) as prev_day,
  lag(mischief_score) over(ORDER by log_date) as prev_score 
from grinch_mischief_log ) t
