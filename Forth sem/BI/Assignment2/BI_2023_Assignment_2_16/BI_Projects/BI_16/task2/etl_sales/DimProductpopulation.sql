INSERT INTO Dim_Product (ProductKey, ProductName, ProductModelName, ProductSubCategoryName, ProductTopCategoryName, StandardCost, ListPrice, StartDate, EndDate, ProductStatus)
SELECT
    P.ProductID AS ProductKey,
    P.ProductName,
    PM.ProductModelName,
    PSC.Name AS ProductSubCategoryName,
    PTC.Name AS ProductTopCategoryName,
    P.StandardCost,
    P.ListPrice,
    P.SellStartDate AS StartDate,
    P.SellEndDate AS EndDate,
    CASE
        WHEN P.SellEndDate IS NULL OR P.SellEndDate > '2021-09-30' THEN 'Current'
        ELSE 'Discontinued'
    END AS ProductStatus
FROM
    BI_BIKES_16.TB_Product P
INNER JOIN BI_BIKES_16.TB_ProductModel PM ON P.ProductModelID = PM.ProductModelID
INNER JOIN BI_BIKES_16.TB_ProductSubCategory PSC ON P.ProductSubCategoryID = PSC.ProductSubCategoryID
INNER JOIN BI_BIKES_16.TB_ProductTopCategory PTC ON PSC.ProductTopCategoryID = PTC.ProductTopCategoryID;