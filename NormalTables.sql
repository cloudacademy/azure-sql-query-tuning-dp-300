DROP TABLE IF EXISTS Customer
GO

CREATE TABLE Customer (
	Id				int not null identity(1,1),
	Code			varchar(18) not null,
	CustType		char(1) not null,
	[Name]			varchar(65)
 CONSTRAINT [PK_Customer] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF)
) 
GO

DROP TABLE IF EXiSTS Item
GO

CREATE TABLE Item (
	Id				int not null identity(1,1),
	UPC				varchar(20) not null,
	ClassId			int,
	[Description]	varchar(100),
 CONSTRAINT [PK_Item] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF)
) 
GO


DROP TABLE IF EXISTS TranHeader
GO

CREATE TABLE TranHeader (
	Id				int not null identity(1,1),
	Branch			smallint not null,
	TransNo			int	not null,
	Station			tinyint not null,
	Logged			datetime2 not null,
	CustomerId		int not null,
	TransType		char(1) not null,
	TransStatus		char(1) not null,
	Salesperson		char(7),
	TotalBeforeTax	numeric(12,4) not null default (0),
 CONSTRAINT [PK_TranHeader] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF)
) 
GO


DROP TABLE IF EXiSTS TranLine
GO

CREATE TABLE TranLine (
	Id				int not null identity(1,1),
	TranHeaderId	int not null,
	Line			smallint not null,
	ItemId			int not null,
	Quantity		int not null,
	Price			numeric(12,4) not null,
	SubBeforeTax	numeric(12,4) not null default (0),
 CONSTRAINT [PK_TranLine] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF)
) 
GO

INSERT INTO Item (UPC, ClassId, [Description])
SELECT DISTINCT UPC, Class, ItemDesc
FROM SalesData
GO

CREATE UNIQUE INDEX UPC_IDX ON Item (UPC)

ALTER TABLE [dbo].[Item] DROP CONSTRAINT IF EXISTS [FK_Item_Class]
GO

ALTER TABLE [dbo].[Item]  WITH CHECK ADD  CONSTRAINT [FK_Item_Class] FOREIGN KEY(ClassId)
REFERENCES [dbo].[Classes] ([Id])
GO

ALTER TABLE [dbo].[Item] CHECK CONSTRAINT [FK_Item_Class]
GO

INSERT INTO Customer (Code, CustType, [Name])
SELECT DISTINCT Customer, CustType, CustomerName
FROM SalesData
GO

CREATE UNIQUE INDEX Code_IDX ON Customer (Code)

INSERT INTO TranHeader (Branch, TransNo, Station, Logged, CustomerId, TransType, TransStatus, Salesperson, TotalBeforeTax)
SELECT DISTINCT Branch, TransNo, Station, Logged, C.ID, TransType, TransStatus, Salesperson, TotalBeforeTax
FROM SalesData S
JOIN Customer C ON C.Code = S.Customer
GO

CREATE UNIQUE INDEX BranchTranNoStation_IDX ON TranHeader (Branch, TransNo, Station)

ALTER TABLE [dbo].[TranHeader] DROP CONSTRAINT IF EXISTS [FK_TranHeader_Customer]
GO

ALTER TABLE [dbo].[TranHeader]  WITH CHECK ADD  CONSTRAINT [FK_TranHeader_Customer] FOREIGN KEY([CustomerId])
REFERENCES [dbo].[Customer] ([Id])
GO

ALTER TABLE [dbo].[TranHeader] CHECK CONSTRAINT [FK_TranHeader_Customer]
GO


INSERT INTO TranLine (TranHeaderId, Line, ItemId, Quantity, Price, SubBeforeTax)
SELECT H.Id, S.Line, I.Id, S.Quantity, S.Price, S.SubBeforeTax
FROM SalesData S
JOIN TranHeader H ON H.Branch = S.Branch AND H.TransNo = S.TransNo AND H.Station = S.Station
JOIN Item I ON I.UPC = S.UPC
GO

CREATE UNIQUE INDEX HeaderIdLine_IDX ON TranLine (TranHeaderId, Line)


ALTER TABLE [dbo].[TranLine] DROP CONSTRAINT IF EXISTS [FK_TranLine_Item] 
GO

ALTER TABLE [dbo].[TranLine]  WITH CHECK ADD  CONSTRAINT [FK_TranLine_Item] FOREIGN KEY([ItemId])
REFERENCES [dbo].[Item] ([Id])
GO

ALTER TABLE [dbo].[TranLine] CHECK CONSTRAINT [FK_TranLine_Item]
GO

ALTER TABLE [dbo].[TranLine] DROP CONSTRAINT IF EXISTS [FK_TranLine_Header] 
GO

ALTER TABLE [dbo].[TranLine]  WITH CHECK ADD  CONSTRAINT [FK_TranLine_Header] FOREIGN KEY([TranHeaderId])
REFERENCES [dbo].[TranHeader] ([Id])
GO

ALTER TABLE [dbo].[TranLine] CHECK CONSTRAINT [FK_TranLine_Header]
GO



Select Max(Len(salesperson)), AVG(Len(Salesperson)) from SalesData
Select Max(TotalBeforeTax) from SalesData

Select Max(Len(UPC)), AVG(Len(UPC)) from SalesData
Select Max(Len(ItemDesc)), AVG(Len(ItemDesc)) from SalesData
