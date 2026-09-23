CREATE DATABASE AmazonFreshDB;
USE AmazonFreshDB;
CREATE TABLE Customers (
    CustomerID VARCHAR(50) PRIMARY KEY,
    Name VARCHAR(100),
    Age INT NOT NULL CHECK (Age > 18),
    Gender VARCHAR(10),
    City VARCHAR(100),
    State VARCHAR(100),
    Country VARCHAR(100),
    SignupDate DATE,
    PrimeMember VARCHAR(5) DEFAULT 'No'
);

CREATE TABLE Products (
    ProductID VARCHAR(50) PRIMARY KEY,
    ProductName VARCHAR(150),
    Category VARCHAR(100),
    SubCategory VARCHAR(100),
    PricePerUnit DECIMAL(10,2),
    StockQuantity INT,
    SupplierID VARCHAR(50)
);

CREATE TABLE Suppliers (
    SupplierID VARCHAR(50) PRIMARY KEY,
    SupplierName VARCHAR(150),
    ContactPerson VARCHAR(100),
    Phone VARCHAR(20),
    City VARCHAR(100),
    State VARCHAR(100)
);

CREATE TABLE Orders (
    OrderID VARCHAR(50) PRIMARY KEY,
    CustomerID VARCHAR(50),
    OrderDate DATE,
    OrderAmount DECIMAL(10,2),
    DeliveryFee DECIMAL(10,2),
    DiscountApplied DECIMAL(10,2),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

CREATE TABLE Order_Details (
    OrderID VARCHAR(50),
    ProductID VARCHAR(50),
    Quantity INT,
    UnitPrice DECIMAL(10,2),
    Discount DECIMAL(10,2),
    PRIMARY KEY (OrderID, ProductID),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

CREATE TABLE Reviews (
    ReviewID VARCHAR(50) PRIMARY KEY,
    ProductID VARCHAR(50),
    CustomerID VARCHAR(50),
    Rating INT CHECK(Rating BETWEEN 1 AND 5),
    ReviewText TEXT,
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

SELECT COUNT(*) FROM customers;
SELECT COUNT(*) FROM products;
SELECT COUNT(*) FROM suppliers;
SELECT COUNT(*) FROM orders;
SELECT COUNT(*) FROM order_details;
SELECT COUNT(*) FROM reviews;

SELECT
    (SELECT COUNT(*) FROM Customers) AS Customers,
    (SELECT COUNT(*) FROM Products) AS Products,
    (SELECT COUNT(*) FROM Suppliers) AS Suppliers,
    (SELECT COUNT(*) FROM Orders) AS Orders,
    (SELECT COUNT(*) FROM Order_Details) AS Order_Details,
    (SELECT COUNT(*) FROM Reviews) AS Reviews;
    
    SELECT *
FROM Customers
WHERE City = 'Patelberg';

SELECT *
FROM Products
WHERE Category = 'Fruits';

ALTER TABLE Customers
ADD CONSTRAINT UQ_CustomerName UNIQUE (Name);

INSERT INTO Products
VALUES
(
'P502',
'Brown Bread',
'Bakery',
'Bread',
45,
250,
'1cd26290-be3e-4bc7-bed4-c0d0ece13a4b'
);

INSERT INTO Products
VALUES
(
'P503',
'Organic Milk',
'Dairy',
'Milk',
65,
180,
'1cd26290-be3e-4bc7-bed4-c0d0ece13a4b'
);

SELECT *
FROM Products
WHERE ProductID IN ('P501','P502','P503');

SELECT *
FROM Products
WHERE ProductID = 'P501';

UPDATE Products
SET StockQuantity = 200
WHERE ProductID = 'P501';

SELECT *
FROM Products
WHERE ProductID = 'P501';

SELECT *
FROM Products
WHERE ProductID = 'P501';

SELECT DISTINCT City
FROM Suppliers;

SELECT *
FROM Suppliers
WHERE City = 'South Debra';

DELETE FROM Suppliers
WHERE City = 'South Debra';

SELECT *
FROM Suppliers
WHERE City = 'South Debra';

DELETE FROM Products
WHERE ProductID = 'P501';

UPDATE Products
SET PricePerUnit = PricePerUnit * 1.10
WHERE Category = 'Snacks';
SELECT ProductName, Category, PricePerUnit
FROM Products
WHERE Category = 'Snacks';

SELECT
    SUM(OrderAmount) AS Total_Revenue
FROM Orders;

ALTER TABLE Products
ADD Discount DECIMAL(5,2);

SELECT
    ROUND(AVG(OrderAmount),2) AS Average_Order
FROM Orders;

SELECT
    MAX(OrderAmount) AS Highest_Order
FROM Orders;

SELECT
    MIN(OrderAmount) AS Lowest_Order
FROM Orders;

SELECT
COUNT(*) AS Total_Products
FROM Products;

SELECT
Category,
COUNT(*) AS TotalProducts
FROM Products
GROUP BY Category;

SELECT
Category,
ROUND(AVG(PricePerUnit),2) AS AveragePrice
FROM Products
GROUP BY Category;

SELECT Category,
       COUNT(*) AS TotalProducts
FROM Products
GROUP BY Category
HAVING COUNT(*) > 80;

SELECT
    c.CustomerID,
    c.Name,
    SUM(o.OrderAmount) AS TotalSpent
FROM Customers c
JOIN Orders o
ON c.CustomerID = o.CustomerID
GROUP BY c.CustomerID, c.Name
ORDER BY TotalSpent DESC
LIMIT 10;
SELECT
    c.Name,
    o.OrderID,
    o.OrderDate,
    o.OrderAmount
FROM Customers c
INNER JOIN Orders o
ON c.CustomerID = o.CustomerID
ORDER BY o.OrderAmount DESC;
SELECT
    p.ProductName,
    p.Category,
    s.SupplierName,
    s.City
FROM Products p
INNER JOIN Suppliers s
ON p.SupplierID = s.SupplierID;
SELECT
    c.Name,
    p.ProductName,
    r.Rating,
    r.ReviewText
FROM Reviews r
INNER JOIN Customers c
ON r.CustomerID = c.CustomerID
INNER JOIN Products p
ON r.ProductID = p.ProductID
ORDER BY r.Rating DESC;

SELECT
    Name
FROM Customers
WHERE CustomerID =
(
    SELECT CustomerID
    FROM Orders
    ORDER BY OrderAmount DESC
    LIMIT 1
);

SELECT COUNT(*)
FROM Products p
INNER JOIN Suppliers s
ON p.SupplierID = s.SupplierID;

SELECT SupplierID
FROM Products
LIMIT 5;

SELECT SupplierID
FROM Suppliers
LIMIT 5;

CREATE TABLE Categories (
    CategoryID INT AUTO_INCREMENT PRIMARY KEY,
    Category VARCHAR(100),
    SubCategory VARCHAR(100)
);

INSERT INTO Categories (Category, SubCategory)
SELECT DISTINCT Category, SubCategory
FROM Products;

ALTER TABLE Products
ADD CategoryID INT;

UPDATE Products p
JOIN Categories c
ON p.Category = c.Category
AND p.SubCategory = c.SubCategory
SET p.CategoryID = c.CategoryID;

ALTER TABLE Products
ADD CONSTRAINT fk_category
FOREIGN KEY (CategoryID)
REFERENCES Categories(CategoryID);

ALTER TABLE Products
DROP COLUMN Category,
DROP COLUMN SubCategory;

SELECT ProductName,
       Revenue
FROM (
    SELECT p.ProductName,
           SUM(od.Quantity * od.UnitPrice) AS Revenue
    FROM Products p
    JOIN Order_Details od
    ON p.ProductID = od.ProductID
    GROUP BY p.ProductName
) AS Sales
ORDER BY Revenue DESC
LIMIT 3;

SELECT CustomerID,
       Name
FROM Customers
WHERE CustomerID NOT IN
(
    SELECT CustomerID
    FROM Orders
);

SELECT City,
       COUNT(*) AS PrimeMembers
FROM Customers
WHERE PrimeMember = 'Yes'
GROUP BY City
ORDER BY PrimeMembers DESC;

SELECT
    p.Category,
    COUNT(*) AS TotalOrders
FROM Order_Details od
JOIN Products p
ON od.ProductID = p.ProductID
GROUP BY p.Category
ORDER BY TotalOrders DESC
LIMIT 3;