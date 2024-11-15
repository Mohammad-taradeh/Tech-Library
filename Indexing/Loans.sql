USE [Library]
GO
--Loans Index
--we used composite index insted of creating multiple indexes
DROP INDEX IF EXISTS composite_date_index ON Loans
CREATE INDEX composite_date_index ON Loans ([Date Returned],[Due Date], [Date Borrowed]);