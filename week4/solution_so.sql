SELECT 
request_at as "Day",
round(
  sum(case when status in ('cancelled_by_client', 'cancelled_by_driver') then 1 else 0 end) 
  / 
  cast(count(trips.id) as numeric) 
, 2) as "Cancellation Rate"
FROM trips 
INNER JOIN users on users.id = trips.client_id
WHERE users.banned = false
GROUP BY request_at;