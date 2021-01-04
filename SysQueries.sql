SELECT * 
FROM sys.dm_os_memory_clerks
WHERE [name] LIKE '%plans%';

SELECT *
FROM sys.dm_db_persisted_sku_features