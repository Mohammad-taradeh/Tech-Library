--2- Active Borrowers with CTEs: Identify borrowers who've borrowed 2 or more books but haven't returned any using CTEs.

WITH books_borrowers AS
(
	SELECT B.BorrowerID, COUNT(*) AS [# of Books Borrowed]
	FROM Borrowers AS B
	RIGHT JOIN Loans AS L
	ON B.BorrowerID = L.BorrowerID
	GROUP BY B.BorrowerID
),
borrowers_with_unreturned_books AS
(
SELECT B.BorrowerID, Count(*) AS [# of unreturned Books]
FROM Borrowers AS B
	RIGHT JOIN Loans AS L
	ON B.BorrowerID = L.BorrowerID
	Where L.[Date Returned] IS NULL
	GROUP BY B.BorrowerID
),
borrowers_with_2_or_more_books_and_non_returned AS
(
	SELECT X.BorrowerID, X.[# of unreturned Books] AS UnReturned, Y.[# of Books Borrowed] AS Borrowed
	FROM  borrowers_with_unreturned_books AS X INNER JOIN books_borrowers AS Y
	ON X.BorrowerID = Y.BorrowerID
	Where Y.[# of Books Borrowed] >=2 AND X.[# of unreturned Books] = Y.[# of Books Borrowed]
)

SELECT *
FROM  borrowers_with_2_or_more_books_and_non_returned