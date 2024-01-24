SELECT 
    'Europe' AS Region,
    c.FullName AS Customer_Name,
    SUM(f.OrderQty) AS Quantity_Sold,
    RANK() OVER (ORDER BY SUM(f.OrderQty) DESC) AS CustRank
FROM 
    Fact_InternetSales f
JOIN 
    Dim_Customer c ON f.CustomerKey = c.CustomerKey
JOIN 
    Dim_Location l ON f.ShipToLocationKey = l.LocationKey
WHERE 
    l.Region = 'Europe'
GROUP BY 
    c.FullName
ORDER BY 
    Quantity_Sold DESC
LIMIT 5;