SELECT
    loc.Country,
    SUM(f.OrderLineProfit) AS Profit
FROM Fact_InternetSales f
JOIN Dim_Product p ON f.ProductKey = p.ProductKey
JOIN Dim_Location loc ON f.ShipToLocationKey = loc.LocationKey
WHERE p.ListPrice BETWEEN 1000 AND 2000
GROUP BY loc.Country
ORDER BY SUM(f.OrderLineProfit) DESC
LIMIT 3;