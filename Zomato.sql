create database Zomato;
use zomato;


ALTER TABLE Zomato_Orders MODIFY order_id VARCHAR(100);
ALTER TABLE Zomato_
ALTER TABLE Zomato_Restaurants MODIFY restaurant_id VARCHAR(100);Orders MODIFY restaurant_id VARCHAR(100);

ALTER TABLE Zomato_Orders
ADD PRIMARY KEY (order_id);

ALTER TABLE Zomato_Restaurants
MODIFY restaurant_id VARCHAR(100);

CREATE UNIQUE INDEX idx_restaurant_id ON Zomato_Restaurants(restaurant_id);


ALTER TABLE Zomato_Orders
ADD CONSTRAINT fk_restaurant
FOREIGN KEY (restaurant_id) REFERENCES Zomato_Restaurants(restaurant_id)
ON DELETE CASCADE;

SELECT restaurant_id, COUNT(*) 
FROM Zomato_Restaurants 
GROUP BY restaurant_id 
HAVING COUNT(*) > 1;

SELECT order_id, COUNT(*) 
FROM Zomato_orders 
GROUP BY order_id
HAVING COUNT(*) > 1;

SELECT 
    SUM(order_id IS NULL) AS null_order_id,
    SUM(restaurant_id IS NULL) AS null_restaurant_id,
    SUM(customer_id IS NULL) AS null_customer_id,
    SUM(order_date IS NULL) AS null_order_date,
    SUM(order_time IS NULL) AS null_order_time,
    SUM(delivery_time IS NULL) AS null_delivery_time,
    SUM(total_cost IS NULL) AS null_total_cost,
    SUM(item_count IS NULL) AS null_item_count,
    SUM(payment_method IS NULL) AS null_payment_method,
    SUM(customer_rating IS NULL) AS null_customer_rating
FROM Zomato_Orders;

SELECT 
    SUM(restaurant_id IS NULL) AS null_restaurant_id,
    SUM(restaurant_name IS NULL) AS null_restaurant_name,
    SUM(city IS NULL) AS null_city,
    SUM(area IS NULL) AS null_area,
    SUM(cuisine IS NULL) AS null_cuisine,
    SUM(avg_rating IS NULL) AS null_avg_rating,
    SUM(total_ratings IS NULL) AS null_total_ratings,
    SUM(price_range IS NULL) AS null_price_range,
    SUM(delivery_available IS NULL) AS null_delivery_available
FROM Zomato_Restaurants;


SELECT 
    city, 
    COUNT(*) AS restaurant_count
FROM Zomato_Restaurants
GROUP BY city
ORDER BY restaurant_count DESC;

SELECT 
    zr.city, 
    COUNT(zo.order_id) AS total_orders
FROM Zomato_Orders zo
JOIN Zomato_Restaurants zr 
    ON zo.restaurant_id = zr.restaurant_id
GROUP BY zr.city
ORDER BY total_orders DESC
LIMIT 5;


SELECT 
    restaurant_id, 
     ROUND(SUM(total_cost), 0) AS total_revenue
FROM Zomato_Orders
GROUP BY restaurant_id
ORDER BY total_revenue DESC;

SELECT 
    zr.city,
    ROUND(AVG(zo.total_cost), 2) AS avg_order_amount
FROM Zomato_Orders zo
JOIN Zomato_Restaurants zr 
    ON zo.restaurant_id = zr.restaurant_id
GROUP BY zr.city
ORDER BY avg_order_amount DESC;

SELECT 
    zr.restaurant_name,
    zr.restaurant_id, Zr.city,
    ROUND(SUM(zo.total_cost), 2) AS total_sales
FROM Zomato_Orders zo
JOIN Zomato_Restaurants zr 
    ON zo.restaurant_id = zr.restaurant_id
GROUP BY zr.restaurant_id, zr.restaurant_name, Zr.city
ORDER BY total_sales DESC
LIMIT 5;


SELECT 
    zo.order_id,
    zo.customer_id,
    zo.order_date,
    zo.order_time,
    zo.delivery_time,
    zo.total_cost,
    zo.item_count,
    zo.payment_method,
    zo.customer_rating,
    zr.restaurant_id,
    zr.restaurant_name,
    zr.city,
    zr.area,
    zr.cuisine,
    zr.avg_rating,
    zr.total_ratings,
    zr.price_range,
    zr.delivery_available
FROM Zomato_Orders zo
JOIN Zomato_Restaurants zr 
    ON zo.restaurant_id = zr.restaurant_id;