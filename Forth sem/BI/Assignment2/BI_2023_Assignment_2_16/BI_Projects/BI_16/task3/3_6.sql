WITH RankedProducts AS (
    SELECT
        ProductTopCategoryName,
        ProductSubCategoryName,
        ProductModelName,
        SUM(f.OrderQty) AS QuantitySold,
        RANK() OVER (
            PARTITION BY ProductTopCategoryName
            ORDER BY SUM(f.OrderQty) DESC
        ) AS TotalOrderQ
    FROM Fact_InternetSales f
    INNER JOIN Dim_Product p ON f.ProductKey = p.ProductKey
    GROUP BY ProductTopCategoryName, ProductSubCategoryName, ProductModelName
)
SELECT
    ProductTopCategoryName,
    ProductSubCategoryName,
    ProductModelName,
    QuantitySold
FROM RankedProducts
WHERE TotalOrderQ <= 3
ORDER BY ProductTopCategoryName, QuantitySold DESC;