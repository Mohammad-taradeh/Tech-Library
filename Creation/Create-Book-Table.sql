USE [Library]
GO

CREATE TABLE [dbo].[Book Status](
	[id] [int] PRIMARY KEY NOT NULL,
	[status] [varchar](20) NOT NULL
	)
GO

INSERT INTO [dbo].[Book Status](id, status)
VALUES
  (1, 'Available'),
  (2, 'Borrowed');
GO

CREATE TABLE [dbo].[Books](
	[BookID] [int] PRIMARY KEY IDENTITY(1,1) NOT NULL,
	[Title] [varchar](50) NOT NULL,
	[Author] [varchar](50) NOT NULL,
	[ISBN] [varchar](13) NOT NULL,
	[Published Date] [date] NOT NULL,
	[Genre] [varchar](50) NOT NULL,
	[Shelf Location] [varchar](10) NOT NULL,
	[Current Status] [int] NOT NULL DEFAULT 1,
	CONSTRAINT fk_Book_Status FOREIGN KEY ([Current Status]) REFERENCES [Book Status] (id)
)
GO



