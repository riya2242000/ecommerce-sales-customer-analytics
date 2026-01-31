-- USE ecommerce_analytics;
-- SELECT COUNT(*) FROM orders;
-- SET GLOBAL local_infile = 1;

-- USE ecommerce_analytics; 

-- LOAD DATA LOCAL INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/olist_orders_dataset.csv'
-- INTO TABLE orders
-- FIELDS TERMINATED BY ',' 
-- ENCLOSED BY '"'
-- LINES TERMINATED BY '\n' 
-- IGNORE 1 ROWS;

-- SELECT COUNT(*) FROM orders;

-- SET GLOBAL local_infile = 1;

-- LOAD DATA LOCAL INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/archive (1)/olist_order_payments_dataset.csv'
-- INTO TABLE payments
-- FIELDS TERMINATED BY ',' 
-- ENCLOSED BY '"'
-- LINES TERMINATED BY '\n' 
-- IGNORE 1 ROWS;

-- SELECT COUNT(*) FROM payments;
-- -- Expected Result: 103,886 rows

-- SELECT payment_type, 
--        COUNT(*) AS total_transactions, 
--        SUM(payment_value) AS total_revenue
-- FROM payments
-- GROUP BY payment_type
-- ORDER BY total_revenue DESC;

-- SET GLOBAL local_infile = 1;

-- LOAD DATA LOCAL INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/archive (1)/olist_order_items_dataset.csv'
-- INTO TABLE order_items
-- FIELDS TERMINATED BY ',' 
-- ENCLOSED BY '"'
-- LINES TERMINATED BY '\n' 
-- IGNORE 1 ROWS;

-- SELECT COUNT(*) FROM order_items;
-- -- Expected: ~112,650 rows

-- UPDATE order_items 
-- SET shipping_limit_date = STR_TO_DATE(shipping_limit_date, '%Y-%m-%d %H:%i:%s');

-- ALTER TABLE order_items MODIFY shipping_limit_date DATETIME;

-- SELECT order_id, price, freight_value 
-- FROM order_items 
-- WHERE freight_value > price
-- ORDER BY freight_value DESC;

-- SET GLOBAL local_infile = 1;

-- LOAD DATA LOCAL INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/archive (1)/olist_products_dataset.csv'
-- INTO TABLE products
-- FIELDS TERMINATED BY ',' 
-- ENCLOSED BY '"'
-- LINES TERMINATED BY '\n' 
-- IGNORE 1 ROWS;

-- SELECT COUNT(*) FROM products;

-- SELECT 
--     p.product_category_name, 
--     COUNT(oi.order_id) AS total_units_sold, 
--     ROUND(SUM(py.payment_value), 2) AS total_revenue
-- FROM products p
-- JOIN order_items oi ON p.product_id = oi.product_id
-- JOIN payments py ON oi.order_id = py.order_id
-- GROUP BY p.product_category_name
-- ORDER BY total_revenue DESC
-- LIMIT 10;

-- SELECT 
--     DATE_FORMAT(o.order_purchase_timestamp, '%Y-%m') AS order_month,
--     COUNT(DISTINCT o.order_id) AS total_orders,
--     ROUND(SUM(p.payment_value), 2) AS monthly_revenue
-- FROM orders o
-- JOIN payments p ON o.order_id = p.order_id
-- WHERE o.order_status = 'delivered'
-- GROUP BY order_month
-- ORDER BY order_month;

-- USE ecommerce_analytics;

-- CREATE TABLE IF NOT EXISTS category_translation (
--     product_category_name VARCHAR(100),
--     product_category_name_english VARCHAR(100)
-- );

-- TRUNCATE TABLE category_translation;

-- -- Bulk Load the translation file
-- SET GLOBAL local_infile = 1;

-- LOAD DATA LOCAL INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/archive (1)/product_category_name_translation.csv'
-- INTO TABLE category_translation
-- FIELDS TERMINATED BY ',' 
-- ENCLOSED BY '"'
-- LINES TERMINATED BY '\n' 
-- IGNORE 1 ROWS;

-- SELECT 
--     t.product_category_name_english AS category, 
--     COUNT(oi.product_id) AS units_sold, 
--     ROUND(SUM(py.payment_value), 2) AS total_revenue
-- FROM products p
-- JOIN category_translation t ON p.product_category_name = t.product_category_name
-- JOIN order_items oi ON p.product_id = oi.product_id
-- JOIN payments py ON oi.order_id = py.order_id
-- GROUP BY category
-- ORDER BY total_revenue DESC
-- LIMIT 10;

-- SELECT 
--     o.order_id, 
--     o.order_status, 
--     p.payment_value
-- FROM orders o
-- LEFT JOIN payments p ON o.order_id = p.order_id
-- WHERE p.order_id IS NULL;


-- SELECT 
--     c.customer_unique_id, 
--     COUNT(DISTINCT o.order_id) AS total_orders, 
--     ROUND(SUM(p.payment_value), 2) AS total_spent
-- FROM customers c
-- JOIN orders o ON c.customer_id = o.customer_id
-- JOIN payments p ON o.order_id = p.order_id
-- GROUP BY c.customer_unique_id
-- ORDER BY total_spent DESC
-- LIMIT 10;

SELECT 
    order_count, 
    COUNT(*) AS number_of_customers
FROM (
    SELECT customer_unique_id, COUNT(order_id) AS order_count
    FROM orders o
    JOIN customers c ON o.customer_id = c.customer_id
    GROUP BY customer_unique_id
) AS customer_orders
WHERE order_count > 1
GROUP BY order_count;

-- Monthly Revenue using CTE
WITH monthly_revenue AS (
    SELECT
        DATE_TRUNC('month', o.order_purchase_timestamp) AS month,
        SUM(p.payment_value) AS revenue
    FROM orders o
    JOIN payments p ON o.order_id = p.order_id
    GROUP BY 1
)
SELECT
    month,
    revenue,
    revenue - LAG(revenue) OVER (ORDER BY month) AS revenue_change
FROM monthly_revenue;










