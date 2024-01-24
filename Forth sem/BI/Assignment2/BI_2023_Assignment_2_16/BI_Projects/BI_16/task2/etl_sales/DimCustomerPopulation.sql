INSERT INTO Dim_Customer (CustomerKey, AccountNumber, FullName, Gender, Age)
SELECT
    C.CustomerID AS CustomerKey,
    C.AccountNumber,
    CONCAT(P.FirstName, ' ', COALESCE(P.MiddleName, ''), ' ', P.LastName) AS FullName,
    P.Gender,
    TIMESTAMPDIFF(YEAR, P.BirthDate, '2021-09-30') AS Age
FROM
    BI_BIKES_16.TB_Customer as C
INNER JOIN BI_BIKES_16.TB_Person as P ON C.PersonID = P.PersonID;