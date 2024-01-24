INSERT INTO Dim_Location (LocationKey, Country, Region, TaxRate, ShipCoeff)
SELECT
    A.AddressID AS LocationKey,
    C.Country,
    C.Region,
    C.TaxRate,
    C.ShipCoeff
FROM
    BI_BIKES_16.TB_Address as A
INNER JOIN BI_BIKES_16.TB_Country as C ON A.CountryID = C.CountryID;