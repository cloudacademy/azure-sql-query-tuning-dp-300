DROP TABLE IF EXISTS SalesResults1
GO

CREATE TABLE SalesResults1 (
	Branch			int,
	TransNo			Int,
	Station			Int,
	Logged			datetime,
	Salesperson		char(7),
	UserName		varchar(50),
	CustomerName	varchar(65),
	Qty				int,
	Total			Numeric(12,4),
	Amount			Numeric(12,4),
	ItemDesc		varchar(100),
	Department		varchar(50),
	SubDept			varchar(50))
GO

DROP INDEX IF EXISTS SD_Logged_Salesperson_Amount ON SalesData
GO

CREATE NONCLUSTERED INDEX [SD_Logged_Salesperson_Amount]
ON [dbo].[SalesData] ([Logged],[Salesperson],[TotalBeforeTax])
INCLUDE ([Branch],[TransNo],[Station],[CustomerName],[UPC],
		[Department],[SubDepartment],[Quantity],[SubBeforeTax]) 
GO

DROP INDEX IF EXISTS SD_Dept_Logged_Amount ON SalesData
GO

CREATE NONCLUSTERED INDEX [SD_Dept_Logged_Amount]
ON [dbo].[SalesData] ([Department],[Logged],[TotalBeforeTax])
INCLUDE ([Branch],[TransNo],[Station],[CustomerName],
		[Salesperson],[UPC],[SubDepartment],[Quantity],[SubBeforeTax])
GO

DROP INDEX IF EXISTS SD_Logged_Salesperson_Total_CSI ON SalesData
GO


CREATE NONCLUSTERED COLUMNSTORE INDEX [SD_Logged_Salesperson_Total_CSI] ON [dbo].[SalesData]
(
	[Logged],
	[Salesperson],
	[Department],
	[TotalBeforeTax]
)WITH (DROP_EXISTING = OFF, COMPRESSION_DELAY = 0) ON SalesDataParts (Logged)
GO


DECLARE @Logged Date
DECLARE @SaleAmt Money
DECLARE @Dept varchar(20)
DECLARE @SubDept varchar(20)
DECLARE @started DATETIME
DECLARE @finished DATETIME
DECLARE @SaleYear INT
DECLARE @SaleMonth INT
DECLARE @ToDate DATE

SET @started = GETDATE()
SET @SaleAmt = 800
SET @Dept = 'Mobile'
SET @SubDept = 'Postpaid'
SET @SaleYear = 2006

TRUNCATE TABLE SalesResults1
WHILE (@SaleYear < 2020)  BEGIN
	SET @SaleMonth = 1

	WHILE (@SaleMonth < 13) BEGIN
		
		IF @SaleMonth = 12 BEGIN
			SET @ToDate = CAST(@SaleYear + 1 AS Char(4)) + '-01-01'
		END
		ELSE BEGIN
			SET @ToDate = CAST(@SaleYear AS Char(4)) + '-' + RIGHT('0' + CAST(@SaleMonth + 1 AS varchar(2)), 2) + '-01'
		END
		INSERT INTO SalesResults1(Branch, TransNo, Station, Logged, Salesperson, UserName, CustomerName, Qty, Total, Amount, ItemDesc, Department, SubDept)
		SELECT DISTINCT SD.Branch, TransNo, Station, Logged, Salesperson, u.UserName, CustomerName, SD.Quantity, TotalBeforeTax, SubBeforeTax, I.[Description], D.[Description], S.Description
		FROM SalesData SD 
		JOIN Items I ON I.UPC = SD.UPC
		JOIN Departments D ON D.ID = SD.Department AND D.[Description] = @Dept
		JOIN SubDepartments S ON S.ID = SD.SubDepartment
		JOIN B_Users U ON U.Branch = SD.Branch AND U.LoginName = SD.Salesperson
		WHERE SD.Logged >= CAST(@SaleYear AS Char(4)) + '-' + RIGHT('0' + CAST(@SaleMonth AS varchar(2)), 2) + '-01'
		AND SD.Logged < @ToDate
		AND TotalBeforeTax > @SaleAmt
		AND NOT (Salesperson = '' OR Salesperson IS NULL)
		

		SET @SaleMonth = @SaleMonth  + 1
	END
	
	SET @SaleYear = @SaleYear + 1
END

SET @finished = GETDATE()

SELECT DATEDIFF(millisecond,@started,@finished) AS Elapsed_MS;


Select Count(*) from SalesData
Select Count(*) from SalesResults1

DROP TABLE IF EXISTS SalesResults2
GO

CREATE TABLE SalesResults2 (
	Branch			int,
	TransNo			Int,
	Station			Int,
	Logged			datetime,
	Salesperson		char(7),
	UserName		varchar(50),
	CustomerName	varchar(65),
	Qty				int,
	Total			Numeric(12,4),
	Amount			Numeric(12,4),
	ItemDesc		varchar(100),
	Department		varchar(50),
	SubDept			varchar(50))
GO

DROP INDEX IF EXISTS [TH_Logged_Salesperson_Amount] ON TranHeader
GO

CREATE NONCLUSTERED INDEX [TH_Logged_Salesperson_Amount]
ON [dbo].[TranHeader] ([Logged],[Salesperson],[TotalBeforeTax])
INCLUDE ([Branch],[TransNo],[Station],[CustomerId]) ON [PRIMARY]


DROP INDEX IF EXISTS [TL_TranHeader_IDX] ON [dbo].[TranLine]
GO
CREATE NONCLUSTERED INDEX TL_TranHeader_IDX ON dbo.TranLine
(
	TranHeaderId
)
INCLUDE ([ItemId], [Quantity],[SubBeforeTax])


/*  ************************* Columnstore indexes ************************** */
DROP INDEX IF EXISTS [CU_Id_Name_CSI] ON [dbo].[Customer]
GO

CREATE NONCLUSTERED COLUMNSTORE INDEX [CU_Id_Name_CSI] ON [dbo].[Customer]
(
	[Id],
	[Name]
)WITH (DROP_EXISTING = OFF, COMPRESSION_DELAY = 0) ON [PRIMARY]
GO

DROP INDEX IF EXISTS TH_Logged_Salesperson_Total_CSI ON TranHeader
GO

CREATE NONCLUSTERED COLUMNSTORE INDEX [TH_Logged_Salesperson_Total_CSI] ON [dbo].[TranHeader]
(
	[Logged],
	[Salesperson],
	[TotalBeforeTax]
)WITH (DROP_EXISTING = OFF, COMPRESSION_DELAY = 0) ON SalesDataParts2(Logged)
GO

DROP INDEX IF EXISTS TL_Item_qty_Amount_CSI ON TranLine
GO

CREATE NONCLUSTERED COLUMNSTORE INDEX [TL_Item_qty_Amount_CSI] ON [dbo].[TranLine]
(
	[TranHeaderId]
)WITH (DROP_EXISTING = OFF, COMPRESSION_DELAY = 0) ON [PRIMARY]
GO


/*  ************************* Optimized with MobileItems temporary table ************************** */

CREATE TABLE MobileItems(
	Id				int not null,
	ItemDesc		varchar(100),
	Department		varchar(50),
	SubDepartment	varchar(50)
	CONSTRAINT [PK_MobileItems] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF)
) 
GO

DECLARE @Logged Date
DECLARE @SaleAmt Money
DECLARE @Dept varchar(20)
DECLARE @SubDept varchar(20)
DECLARE @started DATETIME
DECLARE @finished DATETIME
DECLARE @SaleYear INT
DECLARE @SaleMonth INT
DECLARE @ToDate DATE

SET @started = GETDATE()

SET @SaleAmt = 800
SET @Dept = 'Mobile'
SET @SubDept = 'Postpaid'
SET @SaleYear = 2006

TRUNCATE TABLE SalesResults2
TRUNCATE TABLE MobileItems

INSERT INTO MobileItems(Id, ItemDesc, Department, SubDepartment)
SELECT I.Id, I.Description AS ItemDesc, D.Description AS Department, S.Description AS SubDepartment 
FROM Item I
JOIN Classes C ON C.Id = I.ClassId
JOIN SubDepartments S ON S.ID = C.SubDepID
JOIN Departments D ON D.Id = S.DepID
WHERE D.Description = @Dept


WHILE (@SaleYear < 2020)  BEGIN
	SET @SaleMonth = 1

	WHILE (@SaleMonth < 13) BEGIN
		
		IF @SaleMonth = 12 BEGIN
			SET @ToDate = CAST(@SaleYear + 1 AS Char(4)) + '-01-01'
		END
		ELSE BEGIN
			SET @ToDate = CAST(@SaleYear AS Char(4)) + '-' + RIGHT('0' + CAST(@SaleMonth + 1 AS varchar(2)), 2) + '-01'
		END

		INSERT INTO SalesResults2(Branch, TransNo, Station, Logged, Salesperson, UserName, CustomerName, Qty, Total, Amount, ItemDesc, Department, SubDept)
		SELECT DISTINCT H.Branch, H.TransNo, H.Station, H.Logged, H.Salesperson, u.UserName, C.Name, L.Quantity, H.TotalBeforeTax, L.SubBeforeTax, I.ItemDesc, I.Department, I.SubDepartment
		FROM TranHeader H WITH(INDEX (TH_Logged_Salesperson_Total_CSI))
		JOIN TranLine L WITH (INDEX (PK_TranLine)) ON L.TranHeaderId = H.Id
		JOIN MobileItems I ON I.Id = L.ItemId
		JOIN B_Users U ON U.Branch = H.Branch AND U.LoginName = H.Salesperson
		JOIN Customer C ON C.Id = H.CustomerId
		WHERE H.Logged >= CAST(@SaleYear AS Char(4)) + '-' + RIGHT('0' + CAST(@SaleMonth AS varchar(2)), 2) + '-01'
		AND H.Logged < @ToDate
		AND H.TotalBeforeTax > @SaleAmt
		AND NOT (Salesperson = '' OR Salesperson IS NULL)

		SET @SaleMonth = @SaleMonth  + 1
	END
	
	SET @SaleYear = @SaleYear + 1
END

SET @finished = GETDATE()

SELECT DATEDIFF(millisecond,@started,@finished) AS Elapsed_MS;

