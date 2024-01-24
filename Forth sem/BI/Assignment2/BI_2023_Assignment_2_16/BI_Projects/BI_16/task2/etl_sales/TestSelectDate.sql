SELECT
    (YEAR(SOH.OrderDate) * 10000 + MONTH(SOH.OrderDate) * 100 + DAY(SOH.OrderDate)) AS DateKey, OrderDate as FullDateAlternatekey, dayofweek(OrderDate) as DayNumberOfWeek
FROM
    BI_Bikes_16.TB_SalesOrderHeader SOH
UNION ALL
SELECT
    (YEAR(SOH.DueDate) * 10000 + MONTH(SOH.DueDate) * 100 + DAY(SOH.DueDate)) AS DateKey, DueDate as FullDateAlternatekey
FROM
    BI_Bikes_16.TB_SalesOrderHeader SOH
UNION ALL
SELECT
    (YEAR(SOH.ShipDate) * 10000 + MONTH(SOH.ShipDate) * 100 + DAY(SOH.ShipDate)) AS DateKey, ShipDate as FullDateAlternatekey
FROM
    BI_Bikes_16.TB_SalesOrderHeader SOH;
    
    
    
    
    