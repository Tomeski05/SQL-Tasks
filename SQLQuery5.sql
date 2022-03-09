

-- 5.1 Select the name of all the pieces. 
-- 5.2  Select all the providers' data. 
-- 5.3 Obtain the average price of each piece (show only the piece code and the average price).
-- 5.4  Obtain the names of all providers who supply piece 1.
-- 5.5 Select the name of pieces provided by provider with code "HAL".
-- 5.6
-- ---------------------------------------------
-- !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
-- Interesting and important one.
-- For each piece, find the most expensive offering of that piece and include the piece name, provider name, and price 
-- (note that there could be two providers who supply the same piece at the most expensive price).
-- ---------------------------------------------
-- 5.7 Add an entry to the database to indicate that "Skellington Supplies" (code "TNBC") will provide sprockets (code "1") for 7 cents each.
-- 5.8 Increase all prices by one cent.
-- 5.9 Update the database to reflect that "Susan Calvin Corp." (code "RBT") will not supply bolts (code 4).
-- 5.10 Update the database to reflect that "Susan Calvin Corp." (code "RBT") will not supply any pieces 
    -- (the provider should still remain in the database).



CREATE TABLE Pieces (
 Code INTEGER PRIMARY KEY NOT NULL,
 Name TEXT NOT NULL
 );
CREATE TABLE Providers (
 Code VARCHAR(40) 
 PRIMARY KEY NOT NULL,  
 Name TEXT NOT NULL 
 );
CREATE TABLE Provides (
 Piece INTEGER, 
 FOREIGN KEY (Piece) REFERENCES Pieces(Code),
 Provider VARCHAR(40), 
 FOREIGN KEY (Provider) REFERENCES Providers(Code),  
 Price INTEGER NOT NULL,
 PRIMARY KEY(Piece, Provider) 
 );
 
-- alternative one for SQLite
  /* 
 CREATE TABLE Provides (
 Piece INTEGER,
 Provider VARCHAR(40),  
 Price INTEGER NOT NULL,
 PRIMARY KEY(Piece, Provider) 
 );
 */
 
 
INSERT INTO Providers(Code, Name) VALUES('HAL','Clarke Enterprises');
INSERT INTO Providers(Code, Name) VALUES('RBT','Susan Calvin Corp.');
INSERT INTO Providers(Code, Name) VALUES('TNBC','Skellington Supplies');

INSERT INTO Pieces(Code, Name) VALUES(1,'Sprocket');
INSERT INTO Pieces(Code, Name) VALUES(2,'Screw');
INSERT INTO Pieces(Code, Name) VALUES(3,'Nut');
INSERT INTO Pieces(Code, Name) VALUES(4,'Bolt');

INSERT INTO Provides(Piece, Provider, Price) VALUES(1,'HAL',10);
INSERT INTO Provides(Piece, Provider, Price) VALUES(1,'RBT',15);
INSERT INTO Provides(Piece, Provider, Price) VALUES(2,'HAL',20);
INSERT INTO Provides(Piece, Provider, Price) VALUES(2,'RBT',15);
INSERT INTO Provides(Piece, Provider, Price) VALUES(2,'TNBC',14);
INSERT INTO Provides(Piece, Provider, Price) VALUES(3,'RBT',50);
INSERT INTO Provides(Piece, Provider, Price) VALUES(3,'TNBC',45);
INSERT INTO Provides(Piece, Provider, Price) VALUES(4,'HAL',5);
INSERT INTO Provides(Piece, Provider, Price) VALUES(4,'RBT',7);

-- 5.1 Select the name of all the pieces.
Select Name
From Pieces

-- 5.2  Select all the providers' data.
Select *
From Provides

-- 5.3 Obtain the average price of each piece (show only the piece code and the average price).
Select AVG(Price) As 'Price'
From Provides
Group by Piece

-- 5.4  Obtain the names of all providers who supply piece 1.
Select Providers.Name
From Providers Inner Join Provides
On Providers.Code = Provides.Provider
And Provides.Piece = 1

-- 5.5 Select the name of pieces provided by provider with code "HAL".
Select Pieces.Name
From Pieces Inner Join Provides
On Pieces.Code = Provides.Piece
And Provides.Provider = 'Hal'

-- 5.6
-- ---------------------------------------------
-- !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
-- Interesting and important one.
-- For each piece, find the most expensive offering of that piece and include the piece name, provider name, and price 
-- (note that there could be two providers who supply the same piece at the most expensive price).
Select Pieces.Name, Providers.Name, Price
From Pieces Inner Join Provides On Pieces.Code = Piece 
			Inner Join Providers On Providers.Code = Provider
Where Price = (
	Select Max(Price) From Provides
	Where Piece = Pieces.Code
	)

-- 5.7 Add an entry to the database to indicate that "Skellington Supplies" (code "TNBC") will provide sprockets (code "1") for 7 cents each.



-- 5.8 Increase all prices by one cent.



-- 5.9 Update the database to reflect that "Susan Calvin Corp." (code "RBT") will not supply bolts (code 4).



-- 5.10 Update the database to reflect that "Susan Calvin Corp." (code "RBT") will not supply any pieces 
    -- (the provider should still remain in the database).
