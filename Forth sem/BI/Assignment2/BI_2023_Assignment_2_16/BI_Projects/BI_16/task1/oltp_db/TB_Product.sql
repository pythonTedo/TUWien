CREATE TABLE TB_Product (
    ProductID INT NOT NULL,
    ProductNumber VARCHAR(50) NOT NULL,
    ProductName VARCHAR(50) NOT NULL,
    StandardCost DECIMAL(13,4) NOT NULL,
    ListPrice DECIMAL(13,4) NOT NULL,
    ProductSubCategoryID INT,
    ProductModelID INT,
    SellStartDate DATE NOT NULL,
    SellEndDate DATE,
    CONSTRAINT PK_Product PRIMARY KEY (ProductID),
    CONSTRAINT FK_ProductSubCategoryID_Product FOREIGN KEY (ProductSubCategoryID) REFERENCES TB_ProductSubCategory(ProductSubCategoryID),
    CONSTRAINT FK_ProductModelID_Product FOREIGN KEY (ProductModelID) REFERENCES TB_ProductModel(ProductModelID)
);