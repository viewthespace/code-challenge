SELECT
  t.request_at AS day,
  ROUND(
    (
      SELECT
        COUNT(t1.id)
      FROM
        trips AS t1
      INNER JOIN
        users AS u1 ON u1.id = t1.client_id AND u1.banned = false AND t1.status LIKE 'cancelled%'
      WHERE
        t1.request_at = t.request_at
    ) / COUNT(t.id)::DECIMAL, 2) AS cancelation_rate
  FROM
    trips AS t
  INNER JOIN
    users AS u ON u.id = t.client_id
    AND u.banned = false 
  GROUP BY day;
