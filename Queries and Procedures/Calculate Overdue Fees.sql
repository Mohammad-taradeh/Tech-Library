DROP FUNCTION IF EXISTS fn_CalculateOverdueFees;
GO
CREATE FUNCTION fn_CalculateOverdueFees (@LoanID INT)
RETURNS DECIMAL(10,2)
AS
BEGIN
	DECLARE @DueDate date;
	DECLARE @DateReturned date;
	DECLARE @OverDueDays INT;
	DECLARE @Charge DECIMAL = 1;
	DECLARE @Fee DECIMAL = 0;

	SELECT @DueDate = [Due Date], @DateReturned = [Date Returned]
	FROM Loans
	WHERE LoanID = @LoanID;

	SET @DateReturned = ISNULL(@DateReturned, GETDATE());
	SET @OverDueDays = DATEDIFF(DAY, @DueDate, @DateReturned);

	IF @OverDueDays > 0
	BEGIN
		IF @OverDueDays <= 30
			SET @Fee = @OverDueDays * @Charge;
		ELSE
			SET @Fee = @OverDueDays * 30 * @Charge + ((@OverDueDays - 30) * @Charge * 2)
	END

	RETURN @Fee;
END;
GO

SELECT dbo.fn_CalculateOverdueFees(1) AS OVERDUEFEE;