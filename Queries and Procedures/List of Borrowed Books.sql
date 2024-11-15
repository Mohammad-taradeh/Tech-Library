-- 1-List of Borrowed Books
--Retrieve all books borrowed by a specific borrower, including those currently unreturned.

DROP FUNCTION IF EXISTS borrowed_books_by;
Go
CREATE FUNCTION borrowed_books_by(@id int)
RETURNS TABLE
RETURN
	SELECT B.Title, B.Author, B.Genre
	FROM Books AS B
	INNER JOIN Loans AS L
	ON B.BookID = L.BookID
	WHERE L.BorrowerID = @id

GO
SELECT * from borrowed_books_by(321)