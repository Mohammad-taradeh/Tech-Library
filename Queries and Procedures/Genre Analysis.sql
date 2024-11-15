--4-Popular Genre Analysis using Joins and Window Functions: Identify the most popular genre for a given month.
DECLARE @Year INT = 2023;
DECLARE @Month INT = 11;
Select B.Genre, COUNT(*) AS BOOKS, DENSE_RANK() OVER( ORDER BY B.Genre)
FROM Books AS B
RIGHT JOIN Loans AS L
ON B.BookID = L.BookID
WHERE YEAR(L.[Date Borrowed]) = @Year AND MONTH(L.[Date Borrowed]) = @Month
GROUP BY B.Genre