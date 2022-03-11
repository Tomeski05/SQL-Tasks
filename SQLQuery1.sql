-- 1.1 Select the names of all the products in the store.
-- 1.2 Select the names and the prices of all the products in the store.
-- 1.3 Select the name of the products with a price less than or equal to $200.
-- 1.4 Select all the products with a price between $60 and $120.
-- 1.5 Select the name and price in cents (i.e., the price must be multiplied by 100).
-- 1.6 Compute the average price of all the products.
-- 1.7 Compute the average price of all products with manufacturer code equal to 2.
-- 1.8 Compute the number of products with a price larger than or equal to $180.
-- 1.9 Select the name and price of all products with a price larger than or equal to $180, and sort first by price (in descending order), and then by name (in ascending order).
-- 1.10 Select all the data from the products, including all the data for each product's manufacturer.
-- 1.11 Select the product name, price, and manufacturer name of all the products.
-- 1.12 Select the average price of each manufacturer's products, showing only the manufacturer's code.
-- 1.13 Select the average price of each manufacturer's products, showing the manufacturer's name.
-- 1.14 Select the names of manufacturer whose products have an average price larger than or equal to $150.
-- 1.15 Select the name and price of the cheapest product.
-- 1.16 Select the name of each manufacturer along with the name and price of its most expensive product.
-- 1.17 Add a new product: Loudspeakers, $70, manufacturer 2.
-- 1.18 Update the name of product 8 to "Laser Printer".
-- 1.19 Apply a 10% discount to all products.
-- 1.20 Apply a 10% discount to all products with a price larger than or equal to $120.

CREATE TABLE Manufacturers (
  Code INTEGER,
  Name VARCHAR(255) NOT NULL,
  PRIMARY KEY (Code)   
);

CREATE TABLE Products (
  Code INTEGER,
  Name VARCHAR(255) NOT NULL ,
  Price DECIMAL NOT NULL ,
  Manufacturer INTEGER NOT NULL,
  PRIMARY KEY (Code), 
  FOREIGN KEY (Manufacturer) REFERENCES Manufacturers(Code)
)

INSERT INTO Manufacturers(Code,Name) VALUES(1,'Sony');
INSERT INTO Manufacturers(Code,Name) VALUES(2,'Creative Labs');
INSERT INTO Manufacturers(Code,Name) VALUES(3,'Hewlett-Packard');
INSERT INTO Manufacturers(Code,Name) VALUES(4,'Iomega');
INSERT INTO Manufacturers(Code,Name) VALUES(5,'Fujitsu');
INSERT INTO Manufacturers(Code,Name) VALUES(6,'Winchester');

INSERT INTO Products(Code,Name,Price,Manufacturer) VALUES(1,'Hard drive',240,5);
INSERT INTO Products(Code,Name,Price,Manufacturer) VALUES(2,'Memory',120,6);
INSERT INTO Products(Code,Name,Price,Manufacturer) VALUES(3,'ZIP drive',150,4);
INSERT INTO Products(Code,Name,Price,Manufacturer) VALUES(4,'Floppy disk',5,6);
INSERT INTO Products(Code,Name,Price,Manufacturer) VALUES(5,'Monitor',240,1);
INSERT INTO Products(Code,Name,Price,Manufacturer) VALUES(6,'DVD drive',180,2);
INSERT INTO Products(Code,Name,Price,Manufacturer) VALUES(7,'CD drive',90,2);
INSERT INTO Products(Code,Name,Price,Manufacturer) VALUES(8,'Printer',270,3);
INSERT INTO Products(Code,Name,Price,Manufacturer) VALUES(9,'Toner cartridge',66,3);
INSERT INTO Products(Code,Name,Price,Manufacturer) VALUES(10,'DVD burner',180,2);

-- 1.1 Select the names of all the products in the store.
Select Name
From Products

-- 1.2 Select the names and the prices of all the products in the store.
Select Name, Price
From Products

-- 1.3 Select the name of the products with a price less than or equal to $200.
Select Name
From Products
Where Price <= 200
Order by Price

-- 1.4 Select all the products with a price between $60 and $120.
Select * 
From Products
Where Price Between 60 and 120

-- 1.5 Select the name and price in cents (i.e., the price must be multiplied by 100).
Select Name, Price,
Price * 100 As Total
From Products

-- 1.6 Compute the average price of all the products.
Select AVG(Price)
As "Average Price"
From Products

-- 1.7 Compute the average price of all products with manufacturer code equal to 2.
Select AVG(Price)
As "Average Price"
From Products
Where Code = 2

-- 1.8 Compute the number of products with a price larger than or equal to $180.
Select *
From Products
Where Price >= 180
Order by Price

-- 1.9 Select the name and price of all products with a price larger than or equal to $180, and sort first by price (in descending order), and then by name (in ascending order).
Select Name, Price From Products
Where Price >= 180
Order by Price Desc -- Name Asc

-- 1.10 Select all the data from the products, including all the data for each product's manufacturer.
Select * from Products, Manufacturers

-- 1.11 Select the product name, price, and manufacturer name of all the products.
Select Name, Price, Manufacturer 
From Products
Order by Name Asc

-- 1.12 Select the average price of each manufacturer's products, showing only the manufacturer's code.
Select AVG(all Price)
As "Average"
From Products, Manufacturers
--Where Manufacturers = 'Code'

-- 1.13 Select the average price of each manufacturer's products, showing the manufacturer's name.
Select AVG(all Price)
As "Average"
From Products, Manufacturers
--Where Manufacturers = 'Name'

-- 1.14 Select the names of manufacturer whose products have an average price larger than or equal to $150.
Select Name 
From Products
Where Price >= 150
Order by Name

-- 1.15 Select the name and price of the cheapest product.
Select Name, Price
From Products
Where Price = (Select MIN(Price) From Products)

-- 1.16 Select the name of each manufacturer along with the name and price of its most expensive product.
Select Name, Price
From Products
Where Price = (Select MAX(Price) From Products)

-- 1.17 Add a new product: Loudspeakers, $70, manufacturer 2.
Insert into Products (Code, Name, Price, Manufacturer)
Values (11, 'Loudspeakers', $70, 2)

-- 1.18 Update the name of product 8 to "Laser Printer".
Update Products
Set Name = 'Laser Printer'
Where Code = 8

-- 1.19 Apply a 10% discount to all products.
Update Products
Set Price = 10 * Price

-- 1.20 Apply a 10% discount to all products with a price larger than or equal to $120.
Update Products
Set Price = 10 * Price 
Where Price >= 120

