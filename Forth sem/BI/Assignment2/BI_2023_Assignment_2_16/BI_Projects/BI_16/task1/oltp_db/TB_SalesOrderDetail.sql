CREATE TABLE TB_SalesOrderDetail (
    SalesOrderDetailID INT NOT NULL,
    SalesOrderID INT NOT NULL,
    ProductID INT NOT NULL,
    OrderQty INT NOT NULL,
    UnitPrice DECIMAL(13,4) NOT NULL,
    CONSTRAINT PK_SalesOrderDetail PRIMARY KEY (SalesOrderDetailID),
    CONSTRAINT FK_SalesOrderID_SalesOrderDetail FOREIGN KEY (SalesOrderID) REFERENCES TB_SalesOrderHeader(SalesOrderID),
    CONSTRAINT FK_ProductID_SalesOrderDetail FOREIGN KEY (ProductID) REFERENCES TB_Product(ProductID)
);