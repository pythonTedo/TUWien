CREATE TABLE TB_ProductSubCategory (
    ProductSubCategoryID INT NOT NULL,
    ProductTopCategoryID INT NOT NULL,
    `Name` VARCHAR(50) NOT NULL,
    CONSTRAINT PK_ProductSubCategory PRIMARY KEY (ProductSubCategoryID),
    CONSTRAINT FK_ProductTopCategoryID_ProductSubCategory FOREIGN KEY (ProductTopCategoryID) REFERENCES TB_ProductTopCategory(ProductTopCategoryID)
);