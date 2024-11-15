----Create function to calculate the Age in Years
DROP FUNCTION IF EXISTS fn_calculateAge;
GO
CREATE FUNCTION fn_calculateAge (@DOB DATE)
RETURNS INT
AS 
BEGIN
	DECLARE @CurrDate DATE = GETDATE();
	DECLARE @Days INT = DATEDIFF(DAY, @DOB, @CurrDate);
	RETURN ROUND(@Days/365,0)
END;
GO
--Test the function
--SELECT dbo.fn_calculateAge('2002-12-18');
--GO

---- Genre Preference by Age 
WITH AgeGroups AS
(
	SELECT 
		BorrowerID,
		[First Name],
		[Last Name],
		[Date of Birth],
		CASE
			WHEN dbo.fn_calculateAge([Date of Birth]) BETWEEN 0 AND 10 THEN CONCAT('0', '-', '10')
			ELSE CONCAT((dbo.fn_calculateAge([Date of Birth])/10)*10, '-', ((dbo.fn_calculateAge([Date of Birth]) + 9)/10)*10 )
		END AS AgeGroup
	FROM Borrowers B
), GenreCounts As
(
	SELECT AG.AgeGroup, B.Genre, COUNT(*) AS GenreCount
	FROM AgeGroups AG
	JOIN Loans L ON AG.BorrowerID = L.BorrowerID
	JOIN Books B ON L.BookID = B.BookID
	GROUP BY AG.AgeGroup, B.Genre
), PreferredGenres AS 
(
	SELECT AgeGroup, Genre, GenreCount,
		RANK() OVER (PARTITION BY AgeGroup ORDER BY GenreCount DESC) AS GenreRank
	FROM GenreCounts
)
SELECT AgeGroup, Genre AS PreferredGenre, GenreCount AS BorrowCount
FROM PreferredGenres
WHERE GenreRank = 1
ORDER BY AgeGroup;