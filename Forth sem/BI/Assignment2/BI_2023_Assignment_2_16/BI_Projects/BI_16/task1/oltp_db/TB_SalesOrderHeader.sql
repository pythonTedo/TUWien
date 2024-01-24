CREATE TABLE TB_SalesOrderHeader (
    SalesOrderID INT NOT NULL,
    SalesOrderNumber VARCHAR(30) NOT NULL,
    OrderDate DATE NOT NULL,
    DueDate DATE NOT NULL,
    ShipDate DATE,
    OrderStatusID INT NOT NULL,
    CustomerID INT NOT NULL,
    BillToAddressID INT NOT NULL,
    ShipToAddressID INT NOT NULL,
    ShipMethodID INT NOT NULL,
    CONSTRAINT PK_SalesOrderHeader PRIMARY KEY (SalesOrderID),
    CONSTRAINT FK_OrderStatusID_SalesOrderHeader FOREIGN KEY (OrderStatusID) REFERENCES TB_OrderStatus(OrderStatusID),
    CONSTRAINT FK_CustomerID_SalesOrderHeader FOREIGN KEY (CustomerID) REFERENCES TB_Customer(CustomerID),
    CONSTRAINT FK_BillToAddressID_SalesOrderHeader FOREIGN KEY (BillToAddressID) REFERENCES TB_Address(AddressID),
    CONSTRAINT FK_ShipToAddressID_SalesOrderHeader FOREIGN KEY (ShipToAddressID) REFERENCES TB_Address(AddressID),
    CONSTRAINT FK_ShipMethodID_SalesOrderHeader FOREIGN KEY (ShipMethodID) REFERENCES TB_ShipMethod(ShipMethodID)
);