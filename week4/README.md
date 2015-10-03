### Week 4 Coding Challenge - SQL - Cancellation rate

Write a SQL query to find the cancellation rate of requests made by unbanned clients between Oct 1, 2013 and Oct 3, 2013. For the below tables, your SQL query should return the following rows with the cancellation rate being rounded to two decimal places.

Note: Googling sql techniqueus will probably be needed.

```
+------------+-------------------+
|     Day    | Cancellation Rate |
+------------+-------------------+
| 2013-10-01 |       0.33        |
| 2013-10-02 |       0.00        |
| 2013-10-03 |       0.50        |
+------------+-------------------+
```


The Trips table holds all taxi trips. Each trip has a unique Id, while Client_Id and Driver_Id are both foreign keys to the Users_Id at the Users table.

```
+----+-----------+-----------+--------------------+----------+
| Id | Client_Id | Driver_Id |        Status      |Request_at|
+----+-----------+-----------+--------------------+----------+
| 1  |     1     |    10     |     completed      |2013-10-01|
| 2  |     2     |    11     | cancelled_by_driver|2013-10-01|
| 3  |     3     |    12     |     completed      |2013-10-01|
| 4  |     4     |    13     | cancelled_by_client|2013-10-01|
| 5  |     1     |    10     |     completed      |2013-10-02|
| 6  |     2     |    11     |     completed      |2013-10-02|
| 7  |     3     |    12     |     completed      |2013-10-02|
| 8  |     2     |    12     |     completed      |2013-10-03|
| 9  |     3     |    10     |     completed      |2013-10-03| 
| 10 |     4     |    13     | cancelled_by_driver|2013-10-03|
+----+-----------+-----------+--------------------+----------+
```

The Users table holds all users. Each user has an unique Users_Id

```
+----------+--------+--------+
| Users_Id | Banned |  Role  |
+----------+--------+--------+
|    1     |   No   | client |
|    2     |   Yes  | client |
|    3     |   No   | client |
|    4     |   No   | client |
|    10    |   No   | driver |
|    11    |   No   | driver |
|    12    |   No   | driver |
|    13    |   No   | driver |
+----------+--------+--------+
```
### Installation
``` Bash
cd week4
dropdb week4 > /dev/null 2>&1; createdb week4; psql -U viewthespace -d week4 -f ./public.sql
psql -U viewthespace week4
```
