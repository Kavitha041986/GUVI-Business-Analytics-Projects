use retailSalesdb;

USE retailsalesdb;

SELECT COUNT(*) AS Total_Records
FROM retail_sales_final;

SELECT *
FROM retail_sales_final
LIMIT 10;

SELECT
SUM(Invoice IS NULL) AS Invoice_NULL,
SUM(StockCode IS NULL) AS StockCode_NULL,
SUM(Description IS NULL) AS Description_NULL,
SUM(Quantity IS NULL) AS Quantity_NULL,
SUM(InvoiceDate IS NULL) AS InvoiceDate_NULL,
SUM(Price IS NULL) AS Price_NULL,
SUM(`Customer ID` IS NULL) AS CustomerID_NULL,
SUM(Country IS NULL) AS Country_NULL
FROM retail_sales_final;

ALTER TABLE retail_sales_final
CHANGE COLUMN `Customer ID` CustomerID INT;

ALTER TABLE retail_sales_final
MODIFY Description VARCHAR(255);

DESCRIBE retail_sales_final;

ALTER TABLE retail_sales_final
MODIFY InvoiceDate DATETIME;

DESCRIBE retail_sales_final;

SELECT
    ROUND(SUM(Quantity * Price),2) AS Total_Revenue
FROM retail_sales_final;


SELECT MAX(InvoiceDate) AS Latest_Date,
       MIN(InvoiceDate) AS Earliest_Date
FROM retail_sales_final;

SELECT COUNT(*) AS Total_Rows
FROM retail_sales_final;

SELECT ROUND(SUM(Quantity * Price),2) AS Total_Revenue
FROM retail_sales_final;

SELECT 
    MIN(InvoiceDate) AS Earliest_Date,
    MAX(InvoiceDate) AS Latest_Date
FROM
    retail_sales_final;
RENAME TABLE retail_sales_final TO retail_sales;

SELECT
    ROUND(SUM(Quantity * Price),2) AS Total_Revenue
FROM retail_sales_final; 
SHOW TABLES;

SELECT
    ROUND(SUM(Quantity * Price),2) AS Total_Revenue
FROM retail_sales;

SELECT
    COUNT(DISTINCT CustomerID) AS Total_Customers
FROM retail_sales;
SELECT
    COUNT(DISTINCT StockCode) AS Total_Products
FROM retail_sales;

SELECT
    COUNT(DISTINCT Invoice) AS Total_Orders
FROM retail_sales;

SELECT
    SUM(Quantity) AS Total_Quantity_Sold
FROM retail_sales;
SELECT
    COUNT(DISTINCT Invoice) AS Total_Orders
FROM retail_sales;

SELECT
    ROUND(AVG(Price),2) AS Average_Selling_Price
FROM retail_sales;

SELECT
    ROUND(
        SUM(Quantity * Price) /
        COUNT(DISTINCT Invoice),
        2
    ) AS Average_Order_Value
FROM retail_sales;

SELECT
    COUNT(DISTINCT StockCode) AS Unique_StockCodes,
    COUNT(DISTINCT Description) AS Unique_Product_Names
FROM retail_sales;

SELECT
COUNT(DISTINCT Description) AS Total_Products
FROM retail_sales;

SELECT
    Description,
    ROUND(SUM(Quantity * Price),2) AS Total_Revenue
FROM retail_sales
GROUP BY Description
ORDER BY Total_Revenue DESC
LIMIT 10;

SELECT
    Description,
    SUM(Quantity) AS Quantity_Sold
FROM retail_sales
GROUP BY Description
ORDER BY Quantity_Sold DESC
LIMIT 10;

SELECT
    Description,
    COUNT(DISTINCT Invoice) AS Total_Orders
FROM retail_sales
GROUP BY Description
ORDER BY Total_Orders DESC
LIMIT 10;

SELECT
    Invoice,
    StockCode,
    Description,
    Quantity,
    InvoiceDate,
    Price,
    CustomerID,
    Country,
    COUNT(*) AS Duplicate_Count
FROM retail_sales
GROUP BY
    Invoice,
    StockCode,
    Description,
    Quantity,
    InvoiceDate,
    Price,
    CustomerID,
    Country
HAVING COUNT(*) > 1;
SELECT COUNT(*) AS Negative_Price
FROM retail_sales
WHERE Price < 0;
SELECT COUNT(*) AS Zero_Price
FROM retail_sales
WHERE Price = 0;
SELECT COUNT(*) AS Zero_Quantity
FROM retail_sales
WHERE Quantity = 0;

SELECT COUNT(*) AS Negative_Quantity
FROM retail_sales
WHERE Quantity < 0;
SELECT
    COUNT(*) AS Returns_Transactions
FROM retail_sales
WHERE Quantity < 0
  AND Price < 0;
SELECT
    COUNT(*) AS Sales_Transactions
FROM retail_sales
WHERE Quantity > 0
  AND Price > 0;
  
  SELECT
    COUNT(*) AS Sales_Rows,
    COUNT(DISTINCT Invoice) AS Sales_Orders,
    COUNT(DISTINCT CustomerID) AS Sales_Customers
FROM retail_sales
WHERE Quantity > 0
  AND Price > 0;
  
