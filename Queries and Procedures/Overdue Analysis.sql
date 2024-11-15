
DECLARE @Curr_Date date = GETDATE();
WITH OverDueLoansCTE
AS 
(
	SELECT LoanID, BookID, BorrowerID, [Due Date]
	FROM Loans
	WHERE [Date Returned] IS NULL AND DATEDIFF(DAY, [Due Date], @Curr_Date) > 30
),
OverDoueBorrowers AS
(
	SELECT O.LoanID, O.BookID, O.BorrowerID, O.[Due Date], B.[First Name], B.[Last Name], B.Email
	FROM OverDueLoansCTE AS O
	LEFT Join Borrowers AS B
	ON O.BorrowerID = B.BorrowerID
),
OverDueAnalysis AS
(
	SELECT O.LoanID, O.[Due Date], O.BorrowerID, CONCAT(O.[First Name],' ', O.[Last Name]) AS [Borrower Name], O.Email,
	B.BookID, B.Title, B.ISBN
	FROM OverDoueBorrowers AS O
	JOIN Books AS B
	ON O.BookID = B.BookID
)
SELECT *
FROM OverDueAnalysis

--SELECT 
--    b.BookID,
--    b.Title,
--    b.Author,
--    br.BorrowerID,
--    br.[First Name],
--    br.[Last Name],
--    l.[Date Borrowed],
--    l.[Due Date]
--FROM 
--    Loans l
--JOIN 
--    Books b ON l.BookID = b.BookID
--JOIN 
--    Borrowers br ON l.BorrowerID = br.BorrowerID
--WHERE 
--    l.[Date Returned] IS NULL 
--    AND DATEDIFF(DAY, l.[Due Date], GETDATE()) > 30;