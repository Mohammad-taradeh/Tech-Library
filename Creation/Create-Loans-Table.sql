USE [Library]
GO

CREATE TABLE [dbo].[Loans](
	[LoanID] [int] PRIMARY KEY IDENTITY(1,1) NOT NULL,
	[BorrowerID] [int] NOT NULL,
	[BookID] [int] NOT NULL,
	[Date Borrowed] [date] NOT NULL,
	[Due Date] [date] NOT NULL,
	[Date Returned] [date] NULL,
	CONSTRAINT fk_Loans_Books FOREIGN KEY (BookID) REFERENCES Books (BookID),
	CONSTRAINT fk_Loans_Borrowers FOREIGN KEY (BorrowerID) REFERENCES Borrowers (BorrowerID)
	)
GO

