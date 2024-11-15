DROP PROCEDURE IF EXISTS sp_borrowers_with_overdue_books;
GO
CREATE PROCEDURE sp_borrowers_with_overdue_books
AS 
BEGIN
	CREATE TABLE #OverdueBorrowers (
        BorrowerID INT,
        [Full Name] NVARCHAR(100),
        Email NVARCHAR(100)
    );

	INSERT INTO #OverdueBorrowers (BorrowerID, [Full Name], Email)
	SELECT DISTINCT
		B.BorrowerID,
		CONCAT([First Name], ' ', [Last Name]),
		Email
	FROM Borrowers B
	JOIN Loans L ON B.BorrowerID = L.BorrowerID
	WHERE L.[Date Returned] IS NULL
	AND L.[Due Date] < GETDATE();

	SELECT Temp.BorrowerID, [Full Name], B.BookID, Title, Author, Genre
	FROM #OverdueBorrowers Temp
	JOIN Loans L ON Temp.BorrowerID = L.BorrowerID
	JOIN Books B ON L.BookID = B.BookID
	ORDER BY Temp.BorrowerID, L.[Due Date]

	DROP TABLE #OverdueBorrowers
END;
GO
EXEC dbo.sp_borrowers_with_overdue_books