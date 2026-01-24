-- Ensure you are using the correct database
USE ecommerce_analytics; 

-- Drop and recreate the orders table to avoid import errors

-- SELECT COUNT(*) FROM orders;

-- 1. Truncate the table to start fresh
-- Ensure you are using the correct database
USE ecommerce_analytics; 

-- -- 1. Truncate the table to start fresh
-- TRUNCATE TABLE orders;

-- -- 2. Use the high-speed bulk loader
-- LOAD DATA LOCAL INFILE 'C:\ProgramData/MySQL/MySQL Server 8.0/Uploads/olist_orders_dataset.csv'
-- INTO TABLE orders
-- FIELDS TERMINATED BY ',' 
-- ENCLOSED BY '"'
-- LINES TERMINATED BY '\r\n'  -- Changed to Windows line endings
-- IGNORE 1 ROWS
-- (order_id, customer_id, order_status, order_purchase_timestamp, order_approved_at, 
--  order_delivered_carrier_date, order_delivered_customer_date, order_estimated_delivery_date);

SELECT 
    t.product_category_name_english AS category,
    COUNT(DISTINCT oi.order_id) AS total_orders,
    SUM(oi.order_item_id) AS units_sold,
    ROUND(SUM(py.payment_value), 2) AS total_revenue,
    ROUND(AVG(py.payment_value), 2) AS avg_transaction_value
FROM products p
JOIN category_translation t ON p.product_category_name = t.product_category_name
JOIN order_items oi ON p.product_id = oi.product_id
JOIN payments py ON oi.order_id = py.order_id
GROUP BY category
ORDER BY total_revenue DESC;
