
SELECT
  ROUND(
    CAST (
      SUM (
        CASE
        WHEN t.status LIKE '%cancelled_%' THEN
          1
        ELSE
          0
        END
      ) AS NUMERIC
    ) / COUNT (*),
    2
  )
FROM
  trips t,
  users u
WHERE
  t.client_id = u.id
AND banned = 'f'
GROUP BY
  request_at;
