USE [Library]
GO
--Books Index
DROP INDEX IF EXISTS title_index ON Books
CREATE INDEX title_index ON Books (Title);