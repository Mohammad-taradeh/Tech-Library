SELECT Author, COUNT(L.LoanID) AS [Borrowing Frequency], 
DENSE_RANK() OVER(ORDER BY COUNT(L.LoanID) DESC)
FROM Loans L
RIGHT JOIN Books B
ON L.BookID = B.BookID
GROUP BY Author

