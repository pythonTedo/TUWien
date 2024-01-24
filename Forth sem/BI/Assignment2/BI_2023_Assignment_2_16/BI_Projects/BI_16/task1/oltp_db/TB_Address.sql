CREATE TABLE TB_Address (
    AddressID INT NOT NULL,
    CountryID INT NOT NULL,
    AddressLine VARCHAR(60) NOT NULL,
    City VARCHAR(30) NOT NULL,
    PostalCode VARCHAR(15) NOT NULL,
    CONSTRAINT PK_Address PRIMARY KEY (AddressID),
    CONSTRAINT FK_CountryID_Address FOREIGN KEY (CountryID) REFERENCES TB_Country(CountryID)
);

