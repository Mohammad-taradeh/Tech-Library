--3- Borrowing Frequency using Window Functions: Rank borrowers based on borrowing frequency.
SELECT BorrowerID, COUNT(*) AS Books, DENSE_RANK() OVER (ORDER BY COUNT(*) DESC) AS RANK
FROM Loans
GROUP BY BorrowerID

