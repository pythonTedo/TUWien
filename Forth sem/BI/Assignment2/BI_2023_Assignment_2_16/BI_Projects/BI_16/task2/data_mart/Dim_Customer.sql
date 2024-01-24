CREATE TABLE Dim_Customer (
    CustomerKey INT NOT NULL,
    AccountNumber VARCHAR(30) NOT NULL,
    FullName VARCHAR(150) NOT NULL,
    Gender CHAR(1) NOT NULL CHECK (Gender IN ('M', 'F')),
    Age INT NOT NULL,
    CONSTRAINT PK_DimCustomer PRIMARY KEY (CustomerKey)
);