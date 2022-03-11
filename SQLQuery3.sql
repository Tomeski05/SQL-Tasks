-- The Warehouse

--3.1 Select all warehouses.
--3.2 Select all boxes with a value larger than $150.
--3.3 Select all distinct contents in all the boxes.
--3.4 Select the average value of all the boxes.
--3.5 Select the warehouse code and the average value of the boxes in each warehouse.
--3.6 Same as previous exercise, but select only those warehouses where the average value of the boxes is greater than 150.
--3.7 Select the code of each box, along with the name of the city the box is located in.
--3.8 Select the warehouse codes, along with the number of boxes in each warehouse. 
    -- Optionally, take into account that some warehouses are empty (i.e., the box count should show up as zero, instead of omitting the warehouse from the result).
--3.9 Select the codes of all warehouses that are saturated (a warehouse is saturated if the number of boxes in it is larger than the warehouse's capacity).
--3.10 Select the codes of all the boxes located in Chicago.
--3.11 Create a new warehouse in New York with a capacity for 3 boxes.
--3.12 Create a new box, with code "H5RT", containing "Papers" with a value of $200, and located in warehouse 2.
--3.13 Reduce the value of all boxes by 15%.
--3.14 Remove all boxes with a value lower than $100.
-- 3.15 Remove all boxes from saturated warehouses.
-- 3.16 Add Index for column "Warehouse" in table "boxes"
    -- !!!NOTE!!!: index should NOT be used on small tables in practice
-- 3.17 Print all the existing indexes
    -- !!!NOTE!!!: index should NOT be used on small tables in practice
-- 3.18 Remove (drop) the index you added just
    -- !!!NOTE!!!: index should NOT be used on small tables in practice

CREATE TABLE Warehouses (
   Code INTEGER NOT NULL,
   Location VARCHAR(255) NOT NULL ,
   Capacity INTEGER NOT NULL,
   PRIMARY KEY (Code)
 );

CREATE TABLE Boxes (
    Code CHAR(4) NOT NULL,
    Contents VARCHAR(255) NOT NULL ,
    Value REAL NOT NULL ,
    Warehouse INTEGER NOT NULL,
    PRIMARY KEY (Code),
    FOREIGN KEY (Warehouse) REFERENCES Warehouses(Code)
 )
 
 INSERT INTO Warehouses(Code,Location,Capacity) VALUES(1,'Chicago',3);
 INSERT INTO Warehouses(Code,Location,Capacity) VALUES(2,'Chicago',4);
 INSERT INTO Warehouses(Code,Location,Capacity) VALUES(3,'New York',7);
 INSERT INTO Warehouses(Code,Location,Capacity) VALUES(4,'Los Angeles',2);
 INSERT INTO Warehouses(Code,Location,Capacity) VALUES(5,'San Francisco',8);
 
 INSERT INTO Boxes(Code,Contents,Value,Warehouse) VALUES('0MN7','Rocks',180,3);
 INSERT INTO Boxes(Code,Contents,Value,Warehouse) VALUES('4H8P','Rocks',250,1);
 INSERT INTO Boxes(Code,Contents,Value,Warehouse) VALUES('4RT3','Scissors',190,4);
 INSERT INTO Boxes(Code,Contents,Value,Warehouse) VALUES('7G3H','Rocks',200,1);
 INSERT INTO Boxes(Code,Contents,Value,Warehouse) VALUES('8JN6','Papers',75,1);
 INSERT INTO Boxes(Code,Contents,Value,Warehouse) VALUES('8Y6U','Papers',50,3);
 INSERT INTO Boxes(Code,Contents,Value,Warehouse) VALUES('9J6F','Papers',175,2);
 INSERT INTO Boxes(Code,Contents,Value,Warehouse) VALUES('LL08','Rocks',140,4);
 INSERT INTO Boxes(Code,Contents,Value,Warehouse) VALUES('P0H6','Scissors',125,1);
 INSERT INTO Boxes(Code,Contents,Value,Warehouse) VALUES('P2T6','Scissors',150,2);
 INSERT INTO Boxes(Code,Contents,Value,Warehouse) VALUES('TU55','Papers',90,5);

 --3.1 Select all warehouses.
 Select *
 From Warehouses

 --3.2 Select all boxes with a value larger than $150.
 Select *
 From Boxes
 Where Value > 150
 Order by Value

 --3.3 Select all distinct contents in all the boxes.
 Select Distinct Contents
 From Boxes

 --3.4 Select the average value of all the boxes.
 Select AVG(Value)
 From Boxes

 --3.5 Select the warehouse code and the average value of the boxes in each warehouse.
Select Warehouse, AVG(Value) As "Average"
From Boxes
Group by Warehouse

--3.6 Same as previous exercise, but select only those warehouses where the average value of the boxes is greater than 150.
Select Warehouse, AVG(Value) As "Average"
From Boxes
Group by Warehouse
Having AVG(Value) > 150

--3.7 Select the code of each box, along with the name of the city the box is located in.
Select Boxes.Code, Location
From Boxes Join Warehouses
On Warehouses.Code = Boxes.Warehouse

--3.8 Select the warehouse codes, along with the number of boxes in each warehouse. 
    -- Optionally, take into account that some warehouses are empty (i.e., the box count should show up as zero, instead of omitting the warehouse from the result).
Select Warehouses.Code, Count(Boxes.Code)
From Boxes Left Join Warehouses
On Warehouses.Code = Boxes.Warehouse
Group by Warehouses.Code

--3.9 Select the codes of all warehouses that are saturated (a warehouse is saturated if the number of boxes in it is larger than the warehouse's capacity).
Select Code
From Warehouses
Where Capacity < (
	Select Count (*)
	From Boxes
	Where Warehouse = Warehouses.Code
	)

--3.10 Select the codes of all the boxes located in Chicago.
Select Boxes.Code
From Boxes Right Join Warehouses
On Warehouses.Code = Boxes.Warehouse
Where Location = 'Chicago'

--3.11 Create a new warehouse in New York with a capacity for 3 boxes.
Insert into Warehouses ( Code, Location, Capacity)
Values ( 6, 'New York', 3)

--3.12 Create a new box, with code "H5RT", containing "Papers" with a value of $200, and located in warehouse 2.
Insert into Boxes ( Code, Contents, Value, Warehouse)
Values ('H5RT', 'Papers', $200, 2)

--3.13 Reduce the value of all boxes by 15%.
Update Boxes
Set Value = 0.85 * Value

--3.14 Remove all boxes with a value lower than $100.
Delete
From Boxes
Where Value < 100

-- 3.15 Remove all boxes from saturated warehouses.
Delete 
From Boxes
Where Warehouse In (
	Select Code
	From Warehouses
	Where Capacity < (
		Select Count (*)
		From Boxes
		Where Warehouse = Warehouses.Code
		)
	)

-- 3.16 Add Index for column "Warehouse" in table "boxes"
    -- !!!NOTE!!!: index should NOT be used on small tables in practice
Create Index Index_Warehouse 
On Boxes (Warehouse)

-- 3.17 Print all the existing indexes
    -- !!!NOTE!!!: index should NOT be used on small tables in practice
SELECT
 name AS Index_Name,
 type_desc  As Index_Type,
 is_unique,
 OBJECT_NAME(object_id) As Table_Name
FROM
 sys.indexes
WHERE
 is_hypothetical = 0 AND
 index_id != 0 AND
 object_id = OBJECT_ID('Boxes');
GO

-- 3.18 Remove (drop) the index you added just
    -- !!!NOTE!!!: index should NOT be used on small tables in practice
Drop Index Index_Warehouse