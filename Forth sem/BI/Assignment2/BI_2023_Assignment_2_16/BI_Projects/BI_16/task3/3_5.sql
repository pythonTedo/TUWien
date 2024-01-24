SELECT
    l.Country,
    YEAR(d.FullDateAlternateKey) AS Year,
    monthname(d.FullDateAlternateKey) AS Month,
    SUM(f.OrderLineShippingCost) AS ShippingCosts
FROM Fact_InternetSales f
JOIN Dim_Location l ON f.ShipToLocationKey = l.LocationKey
JOIN Dim_Date d ON f.OrderDateKey = d.DateKey
WHERE
    l.Country = 'United Kingdom' AND
    f.ShipMethod = 'Cargo International' AND
    d.CalendarYear = 2020 AND
    d.MonthNumberOfYear BETWEEN 1 AND 6
GROUP BY l.Country, YEAR(d.FullDateAlternateKey), monthname(d.FullDateAlternateKey)
ORDER BY Year, monthname(d.FullDateAlternateKey);