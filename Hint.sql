
DECLARE @started DATETIME
DECLARE @finished DATETIME

SET @started = GETDATE()

INSERT INTO SalesData(Branch, TransNo, Station, Logged, TransType, TransStatus, Customer, CustomerName, CustType, Salesperson, TotalBeforeTax, Line, UPC, Department, SubDepartment, Class, ItemDesc, L.Quantity, L.Price, L.SubBeforeTax)
SELECT L.Branch, L.TransNo, L.Station, H.Logged, H.TransType, H.TransStatus, H.Customer, C.LastName + ' ' + C.FirstName, H.CustType, H.Salesperson, H.TotalBeforeTax, L.Line, L.UPC, I.Department, I.SubDepartment, I.Class, I.[Description] AS ItemDesc, L.Quantity, L.Price, L.SubBeforeTax
FROM TransHeaders H
JOIN TransLines L WITH (INDEX(Index_upc)) ON L.Branch = H.Branch AND L.TransNo = H.TransNo AND L.Station = H.Station 
JOIN Customers C On C.Code = H.Customer
JOIN Items I ON I.UPC = L.UPC
WHERE L.UPC <> 'TPAY2'

SET @finished = GETDATE()

SELECT DATEDIFF(millisecond,@started,@finished) AS Elapsed_MS;


DROP INDEX IF EXISTS TransLines_UPC_IncAndFiltered ON TransLines
GO

CREATE NONCLUSTERED INDEX [TransLines_UPC_IncAndFiltered]
ON [dbo].[TransLines] ([UPC])
INCLUDE ([TransNo],[Branch],[Station],[Line],[Quantity],[Price],[SubBeforeTax])
WHERE UPC <> 'TPAY2'

DROP INDEX IF EXISTS TransHeader_Customer ON TransHeaders
GO

CREATE NONCLUSTERED INDEX TransHeader_Customer
ON dbo.TransHeaders (Branch, TransNo, Station, Logged, Customer) 
INCLUDE (TransType, TransStatus, TotalBeforeTax, Salesperson, CustType)
GO

DROP INDEX IF EXISTS Customer_Name ON Customers
GO

CREATE NONCLUSTERED INDEX Customer_Name
ON dbo.Customers (Code) 
INCLUDE (LastName, FirstName)
GO

DROP INDEX IF EXISTS Items_Categories ON Items
GO

CREATE NONCLUSTERED INDEX Items_Categories
ON dbo.Items (UPC) 
INCLUDE (Department, SubDepartment, Class, Cost, Price1, [Description])
GO