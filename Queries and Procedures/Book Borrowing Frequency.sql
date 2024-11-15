DROP FUNCTION IF EXISTS fn_BookBorrowingFrequency;
Go

CREATE FUNCTION fn_BookBorrowingFrequency(@BookID INT)
RETURNS INT
AS
BEGIN 
	DECLARE @Count INT = 0;

	SELECT @Count = COUNT(*) 
	FROM Loans 
	WHERE BookID = @BookID;

	RETURN @Count;
END;
GO

SELECT dbo.fn_BookBorrowingFrequency(123) As BorrowingCount;