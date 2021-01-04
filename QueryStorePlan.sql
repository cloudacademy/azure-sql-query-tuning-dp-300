ALTER DATABASE AKPOS
SET QUERY_STORE = ON (OPERATION_MODE = READ_WRITE);
GO

ALTER DATABASE AGDDW
SET QUERY_STORE = ON ( WAIT_STATS_CAPTURE_MODE = ON );

SELECT Txt.query_text_id, Txt.query_sql_text, Pl.plan_id, Qry.*
FROM sys.query_store_plan AS Pl
INNER JOIN sys.query_store_query AS Qry ON Pl.query_id = Qry.query_id
INNER JOIN sys.query_store_query_text AS Txt ON Qry.query_text_id = Txt.query_text_id 
WHERE Qry.query_id = 109

SELECT CAST(query_plan as xml)
FROM sys.query_store_plan P1
WHERE P1.plan_id = 55
