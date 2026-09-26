CREATE DATABASE ZomatoDB;
USE ZomatoDB;


CREATE TABLE Zomato_Restaurants (
    restaurant_id VARCHAR(20) PRIMARY KEY,
    restaurant_name VARCHAR(100),
    city VARCHAR(50),
    area VARCHAR(50),
    cuisine VARCHAR(50),
    avg_rating DECIMAL(3,1),
    total_ratings INT,
    price_range VARCHAR(20),
    delivery_available VARCHAR(10)
);

CREATE TABLE Zomato_Orders (
    order_id VARCHAR(20) PRIMARY KEY,
    restaurant_id VARCHAR(20),
    customer_id VARCHAR(20),
    order_date DATE,
    order_time TIME,
    delivery_time INT,
    total_cost DECIMAL(10,2),
    item_count INT,
    payment_method VARCHAR(30),
    customer_rating DECIMAL(3,1),
    FOREIGN KEY (restaurant_id)
    REFERENCES Zomato_Restaurants(restaurant_id)
);

SELECT COUNT(*) AS Restaurants
FROM Zomato_Restaurants;

SELECT COUNT(*) AS Orders
FROM Zomato_Orders;

SELECT *
FROM Zomato_Restaurants
LIMIT 5;

SELECT *
FROM Zomato_Orders
LIMIT 5;

SELECT restaurant_id, COUNT(*) AS Duplicate_Count
FROM Zomato_Restaurants
GROUP BY restaurant_id
HAVING COUNT(*) > 1;
SELECT order_id, COUNT(*) AS Duplicate_Count
FROM Zomato_Orders
GROUP BY order_id
HAVING COUNT(*) > 1;

SELECT
COUNT(*) AS TotalRows,
SUM(restaurant_name IS NULL) AS RestaurantName_NULL,
SUM(city IS NULL) AS City_NULL,
SUM(area IS NULL) AS Area_NULL,
SUM(cuisine IS NULL) AS Cuisine_NULL,
SUM(avg_rating IS NULL) AS Rating_NULL,
SUM(total_ratings IS NULL) AS TotalRatings_NULL,
SUM(price_range IS NULL) AS PriceRange_NULL,
SUM(delivery_available IS NULL) AS Delivery_NULL
FROM Zomato_Restaurants;

SELECT
COUNT(*) AS TotalRows,
SUM(order_date IS NULL) AS Date_NULL,
SUM(total_cost IS NULL) AS Cost_NULL,
SUM(customer_rating IS NULL) AS Rating_NULL,
SUM(payment_method IS NULL) AS Payment_NULL
FROM Zomato_Orders;

SELECT
city,
COUNT(*) AS Total_Restaurants
FROM Zomato_Restaurants
GROUP BY city
ORDER BY Total_Restaurants DESC;

SELECT
r.city,
COUNT(o.order_id) AS Total_Orders
FROM Zomato_Orders o
JOIN Zomato_Restaurants r
ON o.restaurant_id = r.restaurant_id
GROUP BY r.city
ORDER BY Total_Orders DESC
LIMIT 5;

SELECT
r.restaurant_name,
SUM(o.total_cost) AS Total_Revenue
FROM Zomato_Orders o
JOIN Zomato_Restaurants r
ON o.restaurant_id = r.restaurant_id
GROUP BY r.restaurant_name
ORDER BY Total_Revenue DESC;

SELECT
r.city,
ROUND(AVG(o.total_cost),2) AS Average_Order
FROM Zomato_Orders o
JOIN Zomato_Restaurants r
ON o.restaurant_id = r.restaurant_id
GROUP BY r.city
ORDER BY Average_Order DESC;

SELECT
r.restaurant_name,
SUM(o.total_cost) AS Total_Sales
FROM Zomato_Orders o
JOIN Zomato_Restaurants r
ON o.restaurant_id = r.restaurant_id
GROUP BY r.restaurant_name
ORDER BY Total_Sales DESC
LIMIT 5;

SELECT
o.order_id,
r.restaurant_name,
r.city,
o.order_date,
o.total_cost,
o.customer_rating
FROM Zomato_Orders o
JOIN Zomato_Restaurants r
ON o.restaurant_id = r.restaurant_id;

SELECT
    restaurant_name,
    avg_rating
FROM Zomato_Restaurants
ORDER BY avg_rating DESC
LIMIT 10;















