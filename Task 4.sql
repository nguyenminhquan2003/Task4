CREATE DATABASE Task04

GO

USE Task04

GO

CREATE TABLE Customer(
	CustomerID int PRIMARY KEY,
	CustomerName varchar(150),
	CustomerAddress varchar(200),
	Tel varchar(40)
)
GO
INSERT INTO Customer(CustomerID, CustomerName, CustomerAddress, Tel) VALUES
		(001, 'Emma Stone', 'New York', '08123456781'),
		(002, 'Sam Smith', 'DC', '09234567891'),
		(125, 'Katty Smith', 'Chicago', '01234567892')
GO

CREATE TABLE Product(
	ProductID varchar(40) PRIMARY KEY,
	ProductName varchar(200),
	Unit varchar(40),
	Price money,
	Quantity int,
	Description varchar(300)
)
GO

INSERT INTO Product(ProductID, ProductName, Description, Unit, Price, Quantity) VALUES
		('26D2112', 'Laptop Dell Inspiron 3511 5G8TF', 'New', 'Chiec', 13490000, 15),
		('21M1011', 'Surface Pro 7 Core i5', 'New', 'Chiec', 20690000, 7),
		('1203D18', 'Laptop Gaming Acer Nitro 5 AN515-45-R3SM NH.QBMSV.005', 'Inventory', 'Chiec', 30290000, 18)
GO

CREATE TABLE Orders(
	OrderID varchar(40) PRIMARY KEY,
	CustomerID int FOREIGN KEY REFERENCES Customer(CustomerID),
	OrderDate date
)
GO

INSERT INTO Orders (OrderID, CustomerID, OrderDate) VALUES
		('01', 001, '20211120'),
		('02', 001, '20211128'),
		('03', 002, '20211203'),
		('04', 125, '20211226')
GO

CREATE TABLE OrderDetails(
	OrderID varchar(40) FOREIGN KEY REFERENCES Orders(OrderID),
	ProductID varchar(40) FOREIGN KEY REFERENCES Product(ProductID),
	OrderStatus nvarchar(300),
	Price money,
	Quantity int
)
GO

INSERT INTO OrderDetails(OrderID, ProductID, OrderStatus, Price, Quantity) VALUES
		('01', '26D2112', 'Đa nhan hang', 26980000, 2),
		('02', '21M1011', 'Đa nhan hang', 124140000, 6),
		('02', '1203D18', 'Đa nhan hang ', 90870000, 3),
		('03', '26D2112', 'Đang giao hang', 67450000, 5),
		('04', '1203D18', 'Đang giao hang', 30290000, 1)
GO

--4
	SELECT CustomerName FROM Customer WHERE CustomerID IN (
		SELECT CustomerID FROM Orders
	)
	GO
	
	SELECT ProductName FROM Product
	
	GO

	SELECT OrderID FROM Orders

	GO

--5
	SELECT CustomerName FROM Customer ORDER BY CustomerName 

	SELECT ProductName,Price FROM Product ORDER BY Price DESC
	
	SELECT ProductName FROM Product WHERE ProductID IN (
		SELECT ProductID FROM OrderDetails WHERE OrderID IN (
			SELECT OrderID FROM OrdersWHERE CustomerID = 001
		)
	)

--6
	SELECT COUNT (DISTINCT CustomerID) FROM Orders

	SELECT COUNT (ProductID) FROM Product

	SELECT OrderID, SUM(Price*Quantity) AS 'Total' FROM OrderDetails GROUP BY OrderID 

-- 7
	ALTER TABLE Product
		ADD CONSTRAINT Product_Price CHECK(Price > 0) 
	
	ALTER TABLE OrderDetails
		ADD CONSTRAINT OrdDetails_Price CHECK(Price > 0)
	
	ALTER TABLE Orders
		ADD CONSTRAINT Ord_Date CHECK (OrderDate < GETDATE())
	
	ALTER TABLE Product
		ADD PublicDate DATE	