IF DB_ID('Bokhandel') IS NOT NULL
BEGIN
    ALTER DATABASE Bokhandel SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE Bokhandel;
END
GO

CREATE DATABASE Bokhandel;
GO

USE Bokhandel;
GO
CREATE TABLE [dbo].[Author](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[FirstName] [nvarchar](50) NOT NULL,
	[LastName] [nvarchar](50) NOT NULL,
	[DateOfBirth] [date] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Books]    Script Date: 2026-02-20 13:26:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Books](
	[ISBN13] [char](13) NOT NULL,
	[Title] [nvarchar](200) NOT NULL,
	[Language] [nvarchar](50) NOT NULL,
	[Price] [decimal](10, 2) NOT NULL,
	[PublishingDate] [date] NOT NULL,
	[AuthorId] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ISBN13] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Inventory]    Script Date: 2026-02-20 13:26:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Inventory](
	[StoreId] [int] NOT NULL,
	[ISBN13] [char](13) NOT NULL,
	[Quantity] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[StoreId] ASC,
	[ISBN13] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[TitlesPerAuthor]    Script Date: 2026-02-20 13:26:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[TitlesPerAuthor] AS
SELECT 
	Author.FirstName + ' ' + Author.LastName AS Name,
	CAST(DATEDIFF(Year, Author.DateOfBirth, GETDATE()) AS VARCHAR(3)) + ' years' AS Age,
	CAST((SELECT COUNT(*)
		FROM Books
		WHERE Books.AuthorId = Author.Id) AS VARCHAR(3)) AS Titles,
	CAST(ISNULL((SELECT SUM(Books.Price * Inventory.Quantity)
		FROM Books
		LEFT JOIN Inventory ON Books.ISBN13 = Inventory.ISBN13
		WHERE Books.AuthorId = Author.Id), 0) AS VARCHAR(10)) + ' kr' AS InventoryValue
FROM Author;
GO
/****** Object:  Table [dbo].[Customers]    Script Date: 2026-02-20 13:26:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Customers](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[Email] [nvarchar](100) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OrderDetails]    Script Date: 2026-02-20 13:26:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OrderDetails](
	[OrderDetailId] [int] IDENTITY(1,1) NOT NULL,
	[OrderId] [int] NOT NULL,
	[ISBN13] [char](13) NOT NULL,
	[Quantity] [int] NOT NULL,
	[UnitPrice] [decimal](10, 2) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[OrderDetailId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Orders]    Script Date: 2026-02-20 13:26:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Orders](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CustomerId] [int] NOT NULL,
	[OrderDate] [date] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Stores]    Script Date: 2026-02-20 13:26:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Stores](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[Address] [nvarchar](200) NOT NULL,
	[City] [nvarchar](100) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Author] ON 
GO
INSERT [dbo].[Author] ([Id], [FirstName], [LastName], [DateOfBirth]) VALUES (1, N'J.R.R.', N'Tolkien', CAST(N'1892-01-03' AS Date))
GO
INSERT [dbo].[Author] ([Id], [FirstName], [LastName], [DateOfBirth]) VALUES (2, N'Astrid', N'Lindgren', CAST(N'1907-11-14' AS Date))
GO
INSERT [dbo].[Author] ([Id], [FirstName], [LastName], [DateOfBirth]) VALUES (3, N'H.P.', N'Lovecraft', CAST(N'1890-08-20' AS Date))
GO
INSERT [dbo].[Author] ([Id], [FirstName], [LastName], [DateOfBirth]) VALUES (4, N'Frank', N'Herbert', CAST(N'1920-10-08' AS Date))
GO
SET IDENTITY_INSERT [dbo].[Author] OFF
GO
INSERT [dbo].[Books] ([ISBN13], [Title], [Language], [Price], [PublishingDate], [AuthorId]) VALUES (N'9781212571488', N'Ronja Rövardotter', N'Swedish', CAST(159.00 AS Decimal(10, 2)), CAST(N'1981-08-15' AS Date), 2)
GO
INSERT [dbo].[Books] ([ISBN13], [Title], [Language], [Price], [PublishingDate], [AuthorId]) VALUES (N'9781424491257', N'The Fellowship of the Ring', N'English', CAST(249.00 AS Decimal(10, 2)), CAST(N'1954-07-29' AS Date), 1)
GO
INSERT [dbo].[Books] ([ISBN13], [Title], [Language], [Price], [PublishingDate], [AuthorId]) VALUES (N'9782084751928', N'The Hobbit', N'English', CAST(199.00 AS Decimal(10, 2)), CAST(N'1937-09-21' AS Date), 1)
GO
INSERT [dbo].[Books] ([ISBN13], [Title], [Language], [Price], [PublishingDate], [AuthorId]) VALUES (N'9782221088291', N'The Two Towers', N'English', CAST(249.00 AS Decimal(10, 2)), CAST(N'1954-11-11' AS Date), 1)
GO
INSERT [dbo].[Books] ([ISBN13], [Title], [Language], [Price], [PublishingDate], [AuthorId]) VALUES (N'9784401521851', N'Emil i Lönneberga', N'Swedish', CAST(149.00 AS Decimal(10, 2)), CAST(N'1963-01-01' AS Date), 2)
GO
INSERT [dbo].[Books] ([ISBN13], [Title], [Language], [Price], [PublishingDate], [AuthorId]) VALUES (N'9785521528726', N'Pippi Långstrump', N'Swedish', CAST(149.00 AS Decimal(10, 2)), CAST(N'1945-11-26' AS Date), 2)
GO
INSERT [dbo].[Books] ([ISBN13], [Title], [Language], [Price], [PublishingDate], [AuthorId]) VALUES (N'9785647115328', N'The Call of Cthulhu', N'English', CAST(259.00 AS Decimal(10, 2)), CAST(N'1928-02-01' AS Date), 3)
GO
INSERT [dbo].[Books] ([ISBN13], [Title], [Language], [Price], [PublishingDate], [AuthorId]) VALUES (N'9788788925125', N'The Return of the King', N'English', CAST(299.00 AS Decimal(10, 2)), CAST(N'1955-10-20' AS Date), 1)
GO
INSERT [dbo].[Books] ([ISBN13], [Title], [Language], [Price], [PublishingDate], [AuthorId]) VALUES (N'9789037152887', N'Dune', N'English', CAST(299.00 AS Decimal(10, 2)), CAST(N'1965-08-01' AS Date), 4)
GO
INSERT [dbo].[Books] ([ISBN13], [Title], [Language], [Price], [PublishingDate], [AuthorId]) VALUES (N'9789082715543', N'Bröderna Lejonhjärta', N'Swedish', CAST(179.00 AS Decimal(10, 2)), CAST(N'1973-09-01' AS Date), 2)
GO
SET IDENTITY_INSERT [dbo].[Customers] ON 
GO
INSERT [dbo].[Customers] ([Id], [Name], [Email]) VALUES (1, N'Björn Gunnarsson', N'björnen23@gmail.com')
GO
INSERT [dbo].[Customers] ([Id], [Name], [Email]) VALUES (2, N'Steve Jonsson', N'steve123@hotmail.com')
GO
INSERT [dbo].[Customers] ([Id], [Name], [Email]) VALUES (3, N'Ivar Skogberg', N'skogberg1345@yahoo.com')
GO
INSERT [dbo].[Customers] ([Id], [Name], [Email]) VALUES (4, N'Alicia Lindberg', N'alicialindberg1@gmail.com')
GO
INSERT [dbo].[Customers] ([Id], [Name], [Email]) VALUES (5, N'Esther Svensson', N'esthersvensson@gmail.com')
GO
SET IDENTITY_INSERT [dbo].[Customers] OFF
GO
INSERT [dbo].[Inventory] ([StoreId], [ISBN13], [Quantity]) VALUES (1, N'9781212571488', 10)
GO
INSERT [dbo].[Inventory] ([StoreId], [ISBN13], [Quantity]) VALUES (1, N'9781424491257', 10)
GO
INSERT [dbo].[Inventory] ([StoreId], [ISBN13], [Quantity]) VALUES (1, N'9782084751928', 10)
GO
INSERT [dbo].[Inventory] ([StoreId], [ISBN13], [Quantity]) VALUES (1, N'9782221088291', 10)
GO
INSERT [dbo].[Inventory] ([StoreId], [ISBN13], [Quantity]) VALUES (1, N'9784401521851', 10)
GO
INSERT [dbo].[Inventory] ([StoreId], [ISBN13], [Quantity]) VALUES (1, N'9785521528726', 10)
GO
INSERT [dbo].[Inventory] ([StoreId], [ISBN13], [Quantity]) VALUES (1, N'9785647115328', 10)
GO
INSERT [dbo].[Inventory] ([StoreId], [ISBN13], [Quantity]) VALUES (1, N'9788788925125', 10)
GO
INSERT [dbo].[Inventory] ([StoreId], [ISBN13], [Quantity]) VALUES (1, N'9789037152887', 10)
GO
INSERT [dbo].[Inventory] ([StoreId], [ISBN13], [Quantity]) VALUES (1, N'9789082715543', 10)
GO
INSERT [dbo].[Inventory] ([StoreId], [ISBN13], [Quantity]) VALUES (2, N'9781212571488', 10)
GO
INSERT [dbo].[Inventory] ([StoreId], [ISBN13], [Quantity]) VALUES (2, N'9781424491257', 10)
GO
INSERT [dbo].[Inventory] ([StoreId], [ISBN13], [Quantity]) VALUES (2, N'9782084751928', 10)
GO
INSERT [dbo].[Inventory] ([StoreId], [ISBN13], [Quantity]) VALUES (2, N'9782221088291', 10)
GO
INSERT [dbo].[Inventory] ([StoreId], [ISBN13], [Quantity]) VALUES (2, N'9784401521851', 10)
GO
INSERT [dbo].[Inventory] ([StoreId], [ISBN13], [Quantity]) VALUES (2, N'9785521528726', 10)
GO
INSERT [dbo].[Inventory] ([StoreId], [ISBN13], [Quantity]) VALUES (2, N'9785647115328', 10)
GO
INSERT [dbo].[Inventory] ([StoreId], [ISBN13], [Quantity]) VALUES (2, N'9788788925125', 10)
GO
INSERT [dbo].[Inventory] ([StoreId], [ISBN13], [Quantity]) VALUES (2, N'9789037152887', 10)
GO
INSERT [dbo].[Inventory] ([StoreId], [ISBN13], [Quantity]) VALUES (2, N'9789082715543', 10)
GO
INSERT [dbo].[Inventory] ([StoreId], [ISBN13], [Quantity]) VALUES (3, N'9781212571488', 10)
GO
INSERT [dbo].[Inventory] ([StoreId], [ISBN13], [Quantity]) VALUES (3, N'9781424491257', 10)
GO
INSERT [dbo].[Inventory] ([StoreId], [ISBN13], [Quantity]) VALUES (3, N'9782084751928', 10)
GO
INSERT [dbo].[Inventory] ([StoreId], [ISBN13], [Quantity]) VALUES (3, N'9782221088291', 10)
GO
INSERT [dbo].[Inventory] ([StoreId], [ISBN13], [Quantity]) VALUES (3, N'9784401521851', 10)
GO
INSERT [dbo].[Inventory] ([StoreId], [ISBN13], [Quantity]) VALUES (3, N'9785521528726', 10)
GO
INSERT [dbo].[Inventory] ([StoreId], [ISBN13], [Quantity]) VALUES (3, N'9785647115328', 10)
GO
INSERT [dbo].[Inventory] ([StoreId], [ISBN13], [Quantity]) VALUES (3, N'9788788925125', 10)
GO
INSERT [dbo].[Inventory] ([StoreId], [ISBN13], [Quantity]) VALUES (3, N'9789037152887', 10)
GO
INSERT [dbo].[Inventory] ([StoreId], [ISBN13], [Quantity]) VALUES (3, N'9789082715543', 10)
GO
SET IDENTITY_INSERT [dbo].[OrderDetails] ON 
GO
INSERT [dbo].[OrderDetails] ([OrderDetailId], [OrderId], [ISBN13], [Quantity], [UnitPrice]) VALUES (1, 9, N'9781212571488', 1, CAST(159.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[OrderDetails] ([OrderDetailId], [OrderId], [ISBN13], [Quantity], [UnitPrice]) VALUES (2, 9, N'9784401521851', 1, CAST(149.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[OrderDetails] ([OrderDetailId], [OrderId], [ISBN13], [Quantity], [UnitPrice]) VALUES (3, 10, N'9789082715543', 2, CAST(179.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[OrderDetails] ([OrderDetailId], [OrderId], [ISBN13], [Quantity], [UnitPrice]) VALUES (4, 11, N'9789037152887', 1, CAST(299.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[OrderDetails] ([OrderDetailId], [OrderId], [ISBN13], [Quantity], [UnitPrice]) VALUES (5, 12, N'9782221088291', 1, CAST(249.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[OrderDetails] ([OrderDetailId], [OrderId], [ISBN13], [Quantity], [UnitPrice]) VALUES (6, 12, N'9788788925125', 1, CAST(299.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[OrderDetails] ([OrderDetailId], [OrderId], [ISBN13], [Quantity], [UnitPrice]) VALUES (7, 12, N'9789037152887', 1, CAST(299.00 AS Decimal(10, 2)))
GO
SET IDENTITY_INSERT [dbo].[OrderDetails] OFF
GO
SET IDENTITY_INSERT [dbo].[Orders] ON 
GO
INSERT [dbo].[Orders] ([Id], [CustomerId], [OrderDate]) VALUES (9, 1, CAST(N'2025-10-12' AS Date))
GO
INSERT [dbo].[Orders] ([Id], [CustomerId], [OrderDate]) VALUES (10, 3, CAST(N'2025-10-25' AS Date))
GO
INSERT [dbo].[Orders] ([Id], [CustomerId], [OrderDate]) VALUES (11, 4, CAST(N'2025-11-06' AS Date))
GO
INSERT [dbo].[Orders] ([Id], [CustomerId], [OrderDate]) VALUES (12, 5, CAST(N'2025-12-01' AS Date))
GO
SET IDENTITY_INSERT [dbo].[Orders] OFF
GO
SET IDENTITY_INSERT [dbo].[Stores] ON 
GO
INSERT [dbo].[Stores] ([Id], [Name], [Address], [City]) VALUES (1, N'Magiska Böcker', N'Bondegatan 13', N'Stockholm')
GO
INSERT [dbo].[Stores] ([Id], [Name], [Address], [City]) VALUES (2, N'Äventyrens Bokhandel', N'Västra Kanalgatan 8', N'Malmö')
GO
INSERT [dbo].[Stores] ([Id], [Name], [Address], [City]) VALUES (3, N'Göteborgs Fantasy Bokhandel', N'Djurgårdsgatan 16', N'Göteborg')
GO
SET IDENTITY_INSERT [dbo].[Stores] OFF
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Customer__A9D10534107E54F4]    Script Date: 2026-02-20 13:26:04 ******/
ALTER TABLE [dbo].[Customers] ADD UNIQUE NONCLUSTERED 
(
	[Email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Books]  WITH CHECK ADD FOREIGN KEY([AuthorId])
REFERENCES [dbo].[Author] ([Id])
GO
ALTER TABLE [dbo].[Inventory]  WITH CHECK ADD FOREIGN KEY([ISBN13])
REFERENCES [dbo].[Books] ([ISBN13])
GO
ALTER TABLE [dbo].[Inventory]  WITH CHECK ADD FOREIGN KEY([StoreId])
REFERENCES [dbo].[Stores] ([Id])
GO
ALTER TABLE [dbo].[OrderDetails]  WITH CHECK ADD  CONSTRAINT [FK_OrderDetails_Books] FOREIGN KEY([ISBN13])
REFERENCES [dbo].[Books] ([ISBN13])
GO
ALTER TABLE [dbo].[OrderDetails] CHECK CONSTRAINT [FK_OrderDetails_Books]
GO
ALTER TABLE [dbo].[OrderDetails]  WITH CHECK ADD  CONSTRAINT [FK_OrderDetails_Orders] FOREIGN KEY([OrderId])
REFERENCES [dbo].[Orders] ([Id])
GO
ALTER TABLE [dbo].[OrderDetails] CHECK CONSTRAINT [FK_OrderDetails_Orders]
GO
ALTER TABLE [dbo].[Orders]  WITH CHECK ADD FOREIGN KEY([CustomerId])
REFERENCES [dbo].[Customers] ([Id])
GO
ALTER TABLE [dbo].[Books]  WITH CHECK ADD CHECK  ((NOT [ISBN13] like '%[^0-9]%'))
GO
ALTER TABLE [dbo].[Books]  WITH CHECK ADD CHECK  (([Price]>=(0)))
GO
ALTER TABLE [dbo].[Inventory]  WITH CHECK ADD CHECK  (([Quantity]>=(0)))
GO
USE [master]
GO
ALTER DATABASE [Bokhandel] SET  READ_WRITE 
GO
