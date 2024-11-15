DROP TABLE IF EXISTS AuditLog;
GO
CREATE TABLE AuditLog (
AuditID INT IDENTITY(1,1) PRIMARY KEY,
BookID INT,
StatusChange varchar(50),
ChangeDate DATETIME DEFAULT GETDATE()
);
GO

DROP TRIGGER IF EXISTS trg_LogBookStatusChange;
Go

CREATE TRIGGER trg_LogBookStatusChange
ON Books
AFTER UPDATE
AS
BEGIN
	INSERT INTO AuditLog (BookID, StatusChange, ChangeDate)
	SELECT 
		i.BookID,
		CASE 
            WHEN d.[Current Status] = 1 AND i.[Current Status] = 2 THEN 'Available to Borrowed'
            WHEN d.[Current Status] = 2 AND i.[Current Status] = 1 THEN 'Borrowed to Available'
            ELSE NULL
        END AS StatusChange,
        GETDATE() AS ChangeDate
    FROM 
		inserted i
	JOIN
		deleted d ON i.BookID = d.BookID

END;
GO
