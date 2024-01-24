SELECT
    `Calendar Year`,
    `Month`,
    Country,
    `Tax Amount`
FROM (
    SELECT
        YEAR(fis.OrderDate) AS 'Calendar Year',
        MONTHNAME(fis.OrderDate) AS 'Month',
        l.Country as Country,
        SUM(fis.OrderLineTaxAmt) AS 'Tax Amount',
        MONTH(fis.OrderDate) AS MonthNumber
    FROM
        bi_bikesDW_16.Fact_InternetSales fis
    JOIN
        bi_bikesDW_16.Dim_Location l ON fis.ShipToLocationKey = l.LocationKey
    JOIN
        bi_bikesDW_16.Dim_Customer c ON fis.CustomerKey = c.CustomerKey
    JOIN
        bi_bikesDW_16.Dim_Date d ON fis.OrderDateKey = d.DateKey
    WHERE
        l.Country IN ('France', 'Germany')
        AND YEAR(fis.OrderDate) = 2021
        AND MONTH(fis.OrderDate) BETWEEN 1 AND 6
    GROUP BY
        YEAR(fis.OrderDate),
        MONTHNAME(fis.OrderDate),
        Country,
        MONTH(fis.OrderDate)
) AS subquery
ORDER BY
    `Calendar Year`, MonthNumber, Country;
