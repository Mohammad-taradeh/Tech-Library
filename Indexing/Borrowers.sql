USE [Library]
GO

--Borrowers Index
DROP INDEX IF EXISTS email_index ON Borrowers
CREATE INDEX email_index ON Borrowers (Email);
