-- Total Revenue
SELECT SUM(payment_value) AS total_revenue FROM payments;

-- Monthly Revenue
SELECT 
    DATE_TRUNC('month', order_purchase_timestamp) AS month,
    SUM(payment_value) AS revenue
FROM orders o
JOIN payments p ON o.order_id = p.order_id
GROUP BY month
ORDER BY month;

-- Repeat Customers
SELECT customer_id, COUNT(order_id) AS orders_count
FROM orders
GROUP BY customer_id
HAVING COUNT(order_id) > 1;
