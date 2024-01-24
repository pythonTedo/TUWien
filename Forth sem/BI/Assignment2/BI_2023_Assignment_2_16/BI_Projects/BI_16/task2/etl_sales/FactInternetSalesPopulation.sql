INSERT INTO Fact_InternetSales
(
    SalesOrderLineNumber,
    SalesOrderNumber,
    OrderDateKey,
    OrderDate,
    DueDateKey,
    DueDate,
    ShipDateKey,
    ShipDate,
    ProductKey,
    CustomerKey,
    ShipToLocationKey,
    OrderStatus,
    ShipMethod,
    OrderQty,
    UnitPrice,
    OrderLineTotal,
    OrderLineProfit,
    OrderLineTaxAmt,
    OrderLineShippingCost
)
SELECT
    CONCAT('SOL', SOH.SalesOrderID, '-', SOD.SalesOrderDetailID) AS SalesOrderLineNumber,
    SOH.SalesOrderNumber,
    (YEAR(SOH.OrderDate) * 10000 + MONTH(SOH.OrderDate) * 100 + DAY(SOH.OrderDate)) AS OrderDateKey,
    SOH.OrderDate,
    (YEAR(SOH.DueDate) * 10000 + MONTH(SOH.DueDate) * 100 + DAY(SOH.DueDate)) AS DueDateKey,
    SOH.DueDate,
    (YEAR(SOH.ShipDate) * 10000 + MONTH(SOH.ShipDate) * 100 + DAY(SOH.ShipDate)) AS ShipDateKey,
    SOH.ShipDate as ShipDate,
    SOD.ProductID as ProductKey,
    Cust.CustomerID as CustomerKey,
    SOH.ShipToAddressID as ShipToLocationKey,
    Odr.OrderStatusName as OrderStatus,
    SM.ShipMethodName as ShipMethod,
    SOD.OrderQty,
    SOD.UnitPrice,
    (SOD.OrderQty * SOD.UnitPrice) AS OrderLineTotal,
    (SOD.OrderQty * SOD.UnitPrice - SOD.OrderQty * P.StandardCost) AS OrderLineProfit,
    ((SOD.OrderQty * SOD.UnitPrice) * (Co.TaxRate)) AS OrderLineTaxAmt,
    (PTC.ShipSurcharge + SM.ShipBase + (SOD.OrderQty * SM.ShipRate * Co.ShipCoeff)) AS OrderLineShippingCost
FROM
    BI_Bikes_16.TB_SalesOrderHeader SOH
JOIN BI_Bikes_16.TB_SalesOrderDetail SOD ON SOH.SalesOrderID = SOD.SalesOrderID
JOIN BI_Bikes_16.TB_Product P ON SOD.ProductID = P.ProductID
JOIN BI_Bikes_16.TB_Address Addr ON SOH.ShipToAddressID = Addr.AddressID
JOIN BI_Bikes_16.TB_Country Co ON Addr.CountryID = Co.CountryID
JOIN BI_Bikes_16.TB_ProductSubCategory PSC ON P.ProductSubCategoryID = PSC.ProductSubCategoryID
JOIN BI_Bikes_16.TB_ShipMethod SM ON SOH.ShipMethodID = SM.ShipMethodID
JOIN BI_Bikes_16.TB_ProductTopCategory PTC ON PSC.ProductTopCategoryID = PTC.ProductTopCategoryID
JOIN BI_Bikes_16.TB_Customer Cust ON SOH.CustomerID = Cust.CustomerID
JOIN BI_Bikes_16.TB_OrderStatus Odr ON SOH.OrderStatusID = Odr.OrderStatusID;
