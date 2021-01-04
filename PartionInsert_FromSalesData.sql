CREATE TABLE StopWatch (StartTime datetime)

TRUNCATE TABLE SalesData
GO

DECLARE @started DATETIME
DECLARE @finished DATETIME

DROP TABLE IF EXISTS SalesData1
DROP TABLE IF EXISTS SalesData2
DROP TABLE IF EXISTS SalesData3
DROP TABLE IF EXISTS SalesData4
DROP TABLE IF EXISTS SalesData5
DROP TABLE IF EXISTS SalesData6
DROP TABLE IF EXISTS SalesData7
DROP TABLE IF EXISTS SalesData8
GO



TRUNCATE TABLE StopWatch

INSERT INTO StopWatch VALUES (GetDate())

CREATE TABLE SalesData1 (
	[Id] [int] NOT NULL Identity(1,1),
	[Branch] [smallint] NOT NULL,
	[TransNo] [int] NOT NULL,
	[Station] [smallint] NOT NULL,
	[Logged] [datetime] NOT NULL,
	[TransType] [char](1) NULL,
	[TransStatus] [char](1) NULL,
	[Customer] [varchar](20) NULL,
	[CustomerName] [varchar](65) NULL,
	[CustType] [char](1) NULL,
	[Salesperson] [varchar](20) NULL,
	[TotalBeforeTax] [money] NULL,
	[Line] [smallint] NOT NULL,
	[UPC] [varchar](20) NULL,
	[Department] [smallint] NULL,
	[SubDepartment] [smallint] NULL,
	[Class] [int] NULL,
	[ItemDesc] [varchar](100) NULL,
	[Quantity] [smallint] NULL,
	[Price] [money] NULL,
	[SubBeforeTax] [money] 
 CONSTRAINT [PK_SalesData1] PRIMARY KEY CLUSTERED 
(
	[Logged],[Id] ASC
)WITH (OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PART1]
)  ON [PART1]
GO

ALTER TABLE SalesData1 WITH CHECK ADD CONSTRAINT sd1_logged CHECK(Logged <= '2007-01-01')

CREATE TABLE SalesData2 (
	[Id] [int] NOT NULL Identity(1,1),
	[Branch] [smallint] NOT NULL,
	[TransNo] [int] NOT NULL,
	[Station] [smallint] NOT NULL,
	[Logged] [datetime] NOT NULL,
	[TransType] [char](1) NULL,
	[TransStatus] [char](1) NULL,
	[Customer] [varchar](20) NULL,
	[CustomerName] [varchar](65) NULL,
	[CustType] [char](1) NULL,
	[Salesperson] [varchar](20) NULL,
	[TotalBeforeTax] [money] NULL,
	[Line] [smallint] NOT NULL,
	[UPC] [varchar](20) NULL,
	[Department] [smallint] NULL,
	[SubDepartment] [smallint] NULL,
	[Class] [int] NULL,
	[ItemDesc] [varchar](100) NULL,
	[Quantity] [smallint] NULL,
	[Price] [money] NULL,
	[SubBeforeTax] [money] NULL 
CONSTRAINT [PK_SalesData2] PRIMARY KEY CLUSTERED 
(
	[Logged],[Id] ASC
)WITH (OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PART2]
)  ON [PART2]
GO

ALTER TABLE SalesData2 WITH CHECK 
ADD CONSTRAINT sd2_logged CHECK(Logged > '2007-01-01' AND Logged <= '2008-09-01')

CREATE TABLE SalesData3 (
	[Id] [int] NOT NULL Identity(1,1),
	[Branch] [smallint] NOT NULL,
	[TransNo] [int] NOT NULL,
	[Station] [smallint] NOT NULL,
	[Logged] [datetime] NOT NULL,
	[TransType] [char](1) NULL,
	[TransStatus] [char](1) NULL,
	[Customer] [varchar](20) NULL,
	[CustomerName] [varchar](65) NULL,
	[CustType] [char](1) NULL,
	[Salesperson] [varchar](20) NULL,
	[TotalBeforeTax] [money] NULL,
	[Line] [smallint] NOT NULL,
	[UPC] [varchar](20) NULL,
	[Department] [smallint] NULL,
	[SubDepartment] [smallint] NULL,
	[Class] [int] NULL,
	[ItemDesc] [varchar](100) NULL,
	[Quantity] [smallint] NULL,
	[Price] [money] NULL,
	[SubBeforeTax] [money] NULL
CONSTRAINT [PK_SalesData3] PRIMARY KEY CLUSTERED 
(
	[Logged],[Id] ASC
)WITH (OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PART3]
)  ON [PART3]
GO

ALTER TABLE SalesData3 WITH CHECK ADD CONSTRAINT sd3_logged CHECK(Logged > '2008-09-01' AND Logged <= '2010-05-01')
GO

CREATE TABLE SalesData4 (
	[Id] [int] NOT NULL Identity(1,1),
	[Branch] [smallint] NOT NULL,
	[TransNo] [int] NOT NULL,
	[Station] [smallint] NOT NULL,
	[Logged] [datetime] NOT NULL,
	[TransType] [char](1) NULL,
	[TransStatus] [char](1) NULL,
	[Customer] [varchar](20) NULL,
	[CustomerName] [varchar](65) NULL,
	[CustType] [char](1) NULL,
	[Salesperson] [varchar](20) NULL,
	[TotalBeforeTax] [money] NULL,
	[Line] [smallint] NOT NULL,
	[UPC] [varchar](20) NULL,
	[Department] [smallint] NULL,
	[SubDepartment] [smallint] NULL,
	[Class] [int] NULL,
	[ItemDesc] [varchar](100) NULL,
	[Quantity] [smallint] NULL,
	[Price] [money] NULL,
	[SubBeforeTax] [money] NULL
CONSTRAINT [PK_SalesData4] PRIMARY KEY CLUSTERED 
(
	[Logged],[Id] ASC
)WITH (OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PART4]
)  ON [PART4]
GO

ALTER TABLE SalesData4 WITH CHECK ADD CONSTRAINT sd4_logged CHECK(Logged > '2010-05-01' AND Logged <= '2012-01-01')
GO

CREATE TABLE SalesData5 (
	[Id] [int] NOT NULL Identity(1,1),
	[Branch] [smallint] NOT NULL,
	[TransNo] [int] NOT NULL,
	[Station] [smallint] NOT NULL,
	[Logged] [datetime] NOT NULL,
	[TransType] [char](1) NULL,
	[TransStatus] [char](1) NULL,
	[Customer] [varchar](20) NULL,
	[CustomerName] [varchar](65) NULL,
	[CustType] [char](1) NULL,
	[Salesperson] [varchar](20) NULL,
	[TotalBeforeTax] [money] NULL,
	[Line] [smallint] NOT NULL,
	[UPC] [varchar](20) NULL,
	[Department] [smallint] NULL,
	[SubDepartment] [smallint] NULL,
	[Class] [int] NULL,
	[ItemDesc] [varchar](100) NULL,
	[Quantity] [smallint] NULL,
	[Price] [money] NULL,
	[SubBeforeTax] [money] NULL
CONSTRAINT [PK_SalesData5] PRIMARY KEY CLUSTERED 
(
	[Logged],[Id] ASC
)WITH (OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PART5]
)  ON [PART5]
GO

ALTER TABLE SalesData5 WITH CHECK ADD CONSTRAINT sd5_logged CHECK(Logged > '2012-01-01' AND Logged <= '2014-12-01')
GO


CREATE TABLE SalesData6 (
	[Id] [int] NOT NULL Identity(1,1),
	[Branch] [smallint] NOT NULL,
	[TransNo] [int] NOT NULL,
	[Station] [smallint] NOT NULL,
	[Logged] [datetime] NOT NULL,
	[TransType] [char](1) NULL,
	[TransStatus] [char](1) NULL,
	[Customer] [varchar](20) NULL,
	[CustomerName] [varchar](65) NULL,
	[CustType] [char](1) NULL,
	[Salesperson] [varchar](20) NULL,
	[TotalBeforeTax] [money] NULL,
	[Line] [smallint] NOT NULL,
	[UPC] [varchar](20) NULL,
	[Department] [smallint] NULL,
	[SubDepartment] [smallint] NULL,
	[Class] [int] NULL,
	[ItemDesc] [varchar](100) NULL,
	[Quantity] [smallint] NULL,
	[Price] [money] NULL,
	[SubBeforeTax] [money] NULL
CONSTRAINT [PK_SalesData6] PRIMARY KEY CLUSTERED 
(
	[Logged],[Id] ASC
)WITH (OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PART6]
)  ON [PART6]
GO

ALTER TABLE SalesData6 WITH CHECK ADD CONSTRAINT sd6_logged CHECK(Logged > '2014-12-01' AND Logged <= '2016-08-01')
GO

CREATE TABLE SalesData7 (
	[Id] [int] NOT NULL Identity(1,1),
	[Branch] [smallint] NOT NULL,
	[TransNo] [int] NOT NULL,
	[Station] [smallint] NOT NULL,
	[Logged] [datetime] NOT NULL,
	[TransType] [char](1) NULL,
	[TransStatus] [char](1) NULL,
	[Customer] [varchar](20) NULL,
	[CustomerName] [varchar](65) NULL,
	[CustType] [char](1) NULL,
	[Salesperson] [varchar](20) NULL,
	[TotalBeforeTax] [money] NULL,
	[Line] [smallint] NOT NULL,
	[UPC] [varchar](20) NULL,
	[Department] [smallint] NULL,
	[SubDepartment] [smallint] NULL,
	[Class] [int] NULL,
	[ItemDesc] [varchar](100) NULL,
	[Quantity] [smallint] NULL,
	[Price] [money] NULL,
	[SubBeforeTax] [money] NULL
CONSTRAINT [PK_SalesData7] PRIMARY KEY CLUSTERED 
(
	[Logged],[Id] ASC
)WITH (OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PART7]
)  ON [PART7]
GO

ALTER TABLE SalesData7 WITH CHECK ADD CONSTRAINT sd7_logged CHECK(Logged > '2016-08-01' AND Logged <= '2018-04-01')
GO

CREATE TABLE SalesData8 (
	[Id] [int] NOT NULL Identity(1,1),
	[Branch] [smallint] NOT NULL,
	[TransNo] [int] NOT NULL,
	[Station] [smallint] NOT NULL,
	[Logged] [datetime] NOT NULL,
	[TransType] [char](1) NULL,
	[TransStatus] [char](1) NULL,
	[Customer] [varchar](20) NULL,
	[CustomerName] [varchar](65) NULL,
	[CustType] [char](1) NULL,
	[Salesperson] [varchar](20) NULL,
	[TotalBeforeTax] [money] NULL,
	[Line] [smallint] NOT NULL,
	[UPC] [varchar](20) NULL,
	[Department] [smallint] NULL,
	[SubDepartment] [smallint] NULL,
	[Class] [int] NULL,
	[ItemDesc] [varchar](100) NULL,
	[Quantity] [smallint] NULL,
	[Price] [money] NULL,
	[SubBeforeTax] [money] NULL
CONSTRAINT [PK_SalesData8] PRIMARY KEY CLUSTERED 
(
	[Logged],[Id] ASC
)WITH (OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PART8]
)  ON [PART8]
GO

ALTER TABLE SalesData8 WITH CHECK ADD CONSTRAINT sd8_logged CHECK(Logged > '2018-04-01')
GO



INSERT INTO SalesData1(Branch, TransNo, Station, Logged, TransType, TransStatus, Customer, CustomerName, CustType, Salesperson, TotalBeforeTax, Line, UPC, Department, SubDepartment, Class, ItemDesc, Quantity, Price, SubBeforeTax)
SELECT Branch, TransNo, Station, Logged, TransType, TransStatus, Customer, CustomerName, CustType, Salesperson, TotalBeforeTax, Line, UPC, Department, SubDepartment, Class, ItemDesc, Quantity, Price, SubBeforeTax
FROM SalesData WITH (INDEX (SD_Logged_Salesperson_Amount))
WHERE Logged <= '2007-01-01'
ORDER BY Logged

INSERT INTO SalesData2(Branch, TransNo, Station, Logged, TransType, TransStatus, Customer, CustomerName, CustType, Salesperson, TotalBeforeTax, Line, UPC, Department, SubDepartment, Class, ItemDesc, Quantity, Price, SubBeforeTax)
SELECT Branch, TransNo, Station, Logged, TransType, TransStatus, Customer, CustomerName, CustType, Salesperson, TotalBeforeTax, Line, UPC, Department, SubDepartment, Class, ItemDesc, Quantity, Price, SubBeforeTax
FROM SalesData WITH (INDEX (SD_Logged_Salesperson_Amount))
WHERE Logged > '2007-01-01'
AND Logged <= '2008-09-01'
ORDER BY Logged

INSERT INTO SalesData3(Branch, TransNo, Station, Logged, TransType, TransStatus, Customer, CustomerName, CustType, Salesperson, TotalBeforeTax, Line, UPC, Department, SubDepartment, Class, ItemDesc, Quantity, Price, SubBeforeTax)
SELECT Branch, TransNo, Station, Logged, TransType, TransStatus, Customer, CustomerName, CustType, Salesperson, TotalBeforeTax, Line, UPC, Department, SubDepartment, Class, ItemDesc, Quantity, Price, SubBeforeTax
FROM SalesData WITH (INDEX (SD_Logged_Salesperson_Amount))
WHERE Logged > '2008-09-01'
AND Logged <= '2010-05-01'
ORDER BY Logged

INSERT INTO SalesData4(Branch, TransNo, Station, Logged, TransType, TransStatus, Customer, CustomerName, CustType, Salesperson, TotalBeforeTax, Line, UPC, Department, SubDepartment, Class, ItemDesc, Quantity, Price, SubBeforeTax)
SELECT Branch, TransNo, Station, Logged, TransType, TransStatus, Customer, CustomerName, CustType, Salesperson, TotalBeforeTax, Line, UPC, Department, SubDepartment, Class, ItemDesc, Quantity, Price, SubBeforeTax
FROM SalesData WITH (INDEX (SD_Logged_Salesperson_Amount))
WHERE Logged > '2010-05-01'
AND Logged <= '2012-01-01'
ORDER BY Logged

INSERT INTO SalesData5(Branch, TransNo, Station, Logged, TransType, TransStatus, Customer, CustomerName, CustType, Salesperson, TotalBeforeTax, Line, UPC, Department, SubDepartment, Class, ItemDesc, Quantity, Price, SubBeforeTax)
SELECT Branch, TransNo, Station, Logged, TransType, TransStatus, Customer, CustomerName, CustType, Salesperson, TotalBeforeTax, Line, UPC, Department, SubDepartment, Class, ItemDesc, Quantity, Price, SubBeforeTax
FROM SalesData WITH (INDEX (SD_Logged_Salesperson_Amount))
WHERE Logged> '2012-01-01'
AND Logged <= '2014-12-01'
ORDER BY Logged

INSERT INTO SalesData6(Branch, TransNo, Station, Logged, TransType, TransStatus, Customer, CustomerName, CustType, Salesperson, TotalBeforeTax, Line, UPC, Department, SubDepartment, Class, ItemDesc, Quantity, Price, SubBeforeTax)
SELECT Branch, TransNo, Station, Logged, TransType, TransStatus, Customer, CustomerName, CustType, Salesperson, TotalBeforeTax, Line, UPC, Department, SubDepartment, Class, ItemDesc, Quantity, Price, SubBeforeTax
FROM SalesData WITH (INDEX (SD_Logged_Salesperson_Amount))
WHERE Logged > '2014-12-01'
AND Logged <= '2016-08-01'
ORDER BY Logged

INSERT INTO SalesData7(Branch, TransNo, Station, Logged, TransType, TransStatus, Customer, CustomerName, CustType, Salesperson, TotalBeforeTax, Line, UPC, Department, SubDepartment, Class, ItemDesc, Quantity, Price, SubBeforeTax)
SELECT Branch, TransNo, Station, Logged, TransType, TransStatus, Customer, CustomerName, CustType, Salesperson, TotalBeforeTax, Line, UPC, Department, SubDepartment, Class, ItemDesc, Quantity, Price, SubBeforeTax
FROM SalesData WITH (INDEX (SD_Logged_Salesperson_Amount))
WHERE Logged > '2016-08-01'
AND Logged<= '2018-04-01'
ORDER BY Logged

INSERT INTO SalesData8(Branch, TransNo, Station, Logged, TransType, TransStatus, Customer, CustomerName, CustType, Salesperson, TotalBeforeTax, Line, UPC, Department, SubDepartment, Class, ItemDesc, Quantity, Price, SubBeforeTax)
SELECT Branch, TransNo, Station, Logged, TransType, TransStatus, Customer, CustomerName, CustType, Salesperson, TotalBeforeTax, Line, UPC, Department, SubDepartment, Class, ItemDesc, Quantity, Price, SubBeforeTax
FROM SalesData WITH (INDEX (SD_Logged_Salesperson_Amount))
WHERE Logged > '2018-04-01'
ORDER BY Logged


ALTER TABLE SalesData1 SWITCH TO SalesData PARTITION 1
ALTER TABLE SalesData2 SWITCH TO SalesData PARTITION 2
ALTER TABLE SalesData3 SWITCH TO SalesData PARTITION 3
ALTER TABLE SalesData4 SWITCH TO SalesData PARTITION 4
ALTER TABLE SalesData5 SWITCH TO SalesData PARTITION 5
ALTER TABLE SalesData6 SWITCH TO SalesData PARTITION 6
ALTER TABLE SalesData7 SWITCH TO SalesData PARTITION 7
ALTER TABLE SalesData8 SWITCH TO SalesData PARTITION 8


DECLARE @Started Datetime
DECLARE @finished Datetime
SET @finished = GETDATE()

SELECT @started = StartTime
FROM StopWatch

SELECT DATEDIFF(millisecond,@started,@finished) AS Elapsed_MS;

select count(*) FROM SalesData

SELECT * 
FROM sys.dm_db_partition_stats   
WHERE object_id = OBJECT_ID('dbo.SalesData');  

select t.name as TableName, ps.name as PartitionScheme, pf.name as PartitionFunction, p.partition_number, p.rows, case when pf.boundary_value_on_right=1 then 'RIGHT' else 'LEFT' end [range_type], prv.value [boundary]
from sys.tables t
    join sys.indexes i on t.object_id = i.object_id
    join sys.partition_schemes ps on i.data_space_id = ps.data_space_id
    join sys.partition_functions pf on ps.function_id = pf.function_id
    join sys.partitions p on i.object_id = p.object_id and i.index_id = p.index_id
    join sys.partition_range_values prv on pf.function_id = prv.function_id and p.partition_number = prv.boundary_id
where t.Name = 'SalesData'
order by p.partition_number

select t.name as TableName, ps.name as PartitionScheme, pf.name as PartitionFunction, p.partition_number, p.rows, case when pf.boundary_value_on_right=1 then 'RIGHT' else 'LEFT' end [range_type], prv.value [boundary], i.Name
from sys.tables t
    join sys.indexes i on t.object_id = i.object_id
    join sys.partition_schemes ps on i.data_space_id = ps.data_space_id
    join sys.partition_functions pf on ps.function_id = pf.function_id
    join sys.partitions p on i.object_id = p.object_id and i.index_id = p.index_id
    join sys.partition_range_values prv on pf.function_id = prv.function_id and p.partition_number = prv.boundary_id
where t.Name = 'TranHeader'
order by p.partition_number


Select *
from Sys.filegroups