
SELECT TOP 5 total_worker_time/execution_count AS [Avg CPU Time], Text , plan_handle, query_plan   
FROM sys.dm_exec_query_stats AS qs  
CROSS APPLY sys.dm_exec_query_plan(qs.plan_handle)  
CROSS APPLY sys.dm_exec_sql_text(qs.plan_handle)  
ORDER BY total_worker_time/execution_count DESC;  


SELECT qs.*
FROM sys.dm_exec_query_stats qs
CROSS APPLY sys.dm_exec_sql_text(qs.sql_handle) AS qt  
WHERE qt.Text LIKE 'INSERT INTO SalesData%'


SELECT usecounts, cacheobjtype, objtype, text   
FROM sys.dm_exec_cached_plans   
CROSS APPLY sys.dm_exec_sql_text(plan_handle)   
WHERE usecounts < 8
and usecounts > 1   
ORDER BY cacheobjtype ASC, usecounts DESC; 