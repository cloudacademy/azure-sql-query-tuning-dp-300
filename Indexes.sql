USE [AGDDW]
GO

DROP INDEX IF EXISTS TransCurrency_Site_TransId_IDX ON dbo.TransCurrency



/****** Object:  Index [TransCurrency_Site_TransId_IDX]    Script Date: 10/07/2020 2:50:21 PM ******/
CREATE NONCLUSTERED INDEX [TransCurrency_Site_TransId_IDX] ON [dbo].[TransCurrency]
(
	[SiteId] ASC,
	[TransId] ASC,
	[CurrencyId] ASC,
	[SequenceNumber] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO

ALTER INDEX [TransCurrency_Site_TransId_IDX] ON [dbo].[TransCurrency] DISABLE
GO



USE [AGDDW]
GO

DROP INDEX IF EXISTS TransCurrency_Site_TransId_Currency_Seq_Inc_Amt_IDX ON dbo.TransCurrency
GO

CREATE NONCLUSTERED INDEX [TransCurrency_Site_TransId_Currency_Seq_Inc_Amt_IDX] ON [dbo].[TransCurrency] 
(
	[SiteId] ASC, 
	[TransId] ASC, 
	[CurrencyId] ASC,
	[SequenceNumber] ASC
)
INCLUDE ([Amount])
GO


USE [AGDDW]
GO

DROP INDEX IF EXISTS TransCurrency_Site_TransId_Seq_Inc_CurrencyId_Amt_IDX ON dbo.TransCurrency
GO

CREATE NONCLUSTERED INDEX [TransCurrency_Site_TransId_Seq_Inc_CurrencyId_Amt_IDX]
ON [dbo].[TransCurrency] ([SiteId],[TransId],[SequenceNumber])
INCLUDE ([CurrencyId],[Amount])
GO

USE [AGDDW]
GO

/****** Object:  Index [PK_TransCurrency]    Script Date: 10/07/2020 3:21:43 PM ******/
ALTER TABLE [dbo].[TransCurrency] DROP CONSTRAINT [PK_TransCurrency] WITH ( ONLINE = OFF )
GO

/****** Object:  Index [PK_TransCurrency]    Script Date: 10/07/2020 3:21:43 PM ******/
ALTER TABLE [dbo].[TransCurrency] ADD  CONSTRAINT [PK_TransCurrency] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO

USE [AGDDW]
GO

/****** Object:  Index [TransDetail_SiteTransSeqDetail_IDX]    Script Date: 10/07/2020 3:25:27 PM ******/
DROP INDEX [TransDetail_SiteTransSeqDetail_IDX] ON [dbo].[TransDetail]
GO

/****** Object:  Index [TransDetail_SiteTransSeqDetail_IDX]    Script Date: 10/07/2020 3:25:27 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [TransDetail_SiteTransSeqDetail_IDX] ON [dbo].[TransDetail]
(
	[SiteId] ASC,
	[TransId] ASC,
	[SequenceNumber] ASC,
	[DetailId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO

USE [AGDDW]
GO

/****** Object:  Index [TransDetail__ProcessedTransType_IDX]    Script Date: 10/07/2020 3:32:56 PM ******/
DROP INDEX [TransDetail__ProcessedTransType_IDX] ON [dbo].[TransDetail]
GO

/****** Object:  Index [TransDetail__ProcessedTransType_IDX]    Script Date: 10/07/2020 3:32:56 PM ******/
CREATE NONCLUSTERED INDEX [TransDetail__ProcessedTransType_IDX] ON [dbo].[TransDetail]
(
	[ProcessedDate] ASC,
	[TransType] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO

ALTER TABLE [dbo].[TransDetail] DROP CONSTRAINT [PK_TransDetail] WITH ( ONLINE = OFF )
GO

/****** Object:  Index [PK_TransDetail]    Script Date: 10/07/2020 3:33:13 PM ******/
ALTER TABLE [dbo].[TransDetail] ADD  CONSTRAINT [PK_TransDetail] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO


USE [AGDDW]
GO

/****** Object:  Index [PK_Currency]    Script Date: 10/07/2020 3:33:42 PM ******/
ALTER TABLE [dbo].[Currency] DROP CONSTRAINT [PK_Currency] WITH ( ONLINE = OFF )
GO

/****** Object:  Index [PK_Currency]    Script Date: 10/07/2020 3:33:42 PM ******/
ALTER TABLE [dbo].[Currency] ADD  CONSTRAINT [PK_Currency] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO

