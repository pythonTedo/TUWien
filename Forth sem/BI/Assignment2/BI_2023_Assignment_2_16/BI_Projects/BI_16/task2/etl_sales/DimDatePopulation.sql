INSERT INTO Dim_Date
(
    DateKey,
    FullDateAlternateKey,
    DayNumberOfWeek,
    EnglishDayNameOfWeek,
    DayNumberOfMonth,
    DayNumberOfYear,
    WeekNumberOfYear,
    EnglishMonthName,
    MonthNumberOfYear,
    CalendarQuarter,
    CalendarYear
)

SELECT DISTINCT
    DateKeyCombination.DateKey,
    DateKeyCombination.FullDateAlternateKey,
    DAYOFWEEK(DateKeyCombination.FullDateAlternateKey) - 1 AS DayNumberOfWeek,
    DAYNAME(DateKeyCombination.FullDateAlternateKey) AS EnglishDayNameOfWeek,
    DAY(DateKeyCombination.FullDateAlternateKey) AS DayNumberOfMonth,
    DAYOFYEAR(DateKeyCombination.FullDateAlternateKey) AS DayNumberOfYear,
    WEEK(DateKeyCombination.FullDateAlternateKey, 1) AS WeekNumberOfYear,
    MONTHNAME(DateKeyCombination.FullDateAlternateKey) AS EnglishMonthName,
    MONTH(DateKeyCombination.FullDateAlternateKey) AS MonthNumberOfYear,
    QUARTER(DateKeyCombination.FullDateAlternateKey) AS CalendarQuarter,
    YEAR(DateKeyCombination.FullDateAlternateKey) AS CalendarYear
FROM
    (
        SELECT
            (YEAR(OrderDate) * 10000 + MONTH(OrderDate) * 100 + DAY(OrderDate)) AS DateKey,
            OrderDate AS FullDateAlternateKey
        FROM
            BI_Bikes_16.TB_SalesOrderHeader
        
        UNION
        
        SELECT
            (YEAR(DueDate) * 10000 + MONTH(DueDate) * 100 + DAY(DueDate)),
            DueDate
        FROM
            BI_Bikes_16.TB_SalesOrderHeader
        
        UNION
        
        SELECT
            (YEAR(ShipDate) * 10000 + MONTH(ShipDate) * 100 + DAY(ShipDate)),
            ShipDate
        FROM
            BI_Bikes_16.TB_SalesOrderHeader
    ) AS DateKeyCombination;
