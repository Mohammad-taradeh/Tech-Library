DROP PROCEDURE IF EXISTS sp_BorrowedBooksReport;
GO
CREATE PROCEDURE sp_BorrowedBooksReport (
	@StartDate DATE,
	@EndDate DATE
	)
AS
BEGIN
	SELECT B.BookID, Title, Author, CONCAT([First Name], ' ', [Last Name]) AS Borrower,
	[Date Borrowed],
	[Date Returned]
	FROM Loans L
	JOIN Borrowers Br
	ON L.BorrowerID = Br.BorrowerID
	JOIN Books B
	ON L.BookID = B.BookID
	WHERE [Date Borrowed] BETWEEN @StartDate AND @EndDate
END;
GO
EXEC dbo.sp_BorrowedBooksReport '2015-12-04', '2024-10-7'