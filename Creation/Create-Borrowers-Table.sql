USE [Library]
GO


CREATE TABLE [dbo].[Borrowers](
	[BorrowerID] [int] IDENTITY(1,1) NOT NULL,
	[First Name] [varchar](50) NOT NULL,
	[Last Name] [varchar](50) NOT NULL,
	[Email] [varchar](50) NOT NULL,
	[Date of Birth] [date] NOT NULL,
	[Membership Date] [date] NOT NULL,
	)
GO


