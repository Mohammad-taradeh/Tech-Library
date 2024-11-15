DROP PROCEDURE IF EXISTS sp_AddNewBorrower;
GO
CREATE PROCEDURE sp_AddNewBorrower (
@FirstName varchar(50),
@LastName varchar(50),
@Email varchar(50),
@DOB date,
@MembershipDate date,
@NewBorrowerID INT OUTPUT
)
AS BEGIN
	-- Chek if there is a borrower with the same email
	IF EXISTS (SELECT 1 FROM Borrowers WHERE Email = @Email)
	BEGIN
		-- if email exists rais an error and return
		RAISERROR('A borrower with this email already exists.', 16,1);
		RETURN;
	END
	-- if there is no borrower with the same email add the borrower
	INSERT INTO Borrowers ([First Name], [Last Name], Email, [Date of Birth], [Membership Date])
	VALUES (@FirstName, @LastName, @Email, @DOB, @MembershipDate)
	SET @NewBorrowerID = SCOPE_IDENTITY();
	RETURN;

END;