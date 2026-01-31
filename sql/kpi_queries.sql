-- Total Revenue
SELECT SUM(payment_value) AS total_revenue 
FROM payments;

-- Monthly Revenue (Fixed for MySQL)
SELECT 
    DATE_FORMAT(order_purchase_timestamp, '%Y-%m-01') AS month,
    SUM(payment_value) AS revenue
FROM orders o
JOIN payments p ON o.order_id = p.order_id
GROUP BY month
ORDER BY month;

-- KPI: Monthly Order Count
SELECT
  DATE_FORMAT(order_purchase_timestamp, '%Y-%m') AS month,
  COUNT(order_id) AS total_orders
FROM orders
GROUP BY month
ORDER BY month;

-- KPI: Customer Lifetime Value
SELECT
  o.customer_id,
  SUM(p.payment_value) AS clv
FROM orders o
JOIN payments p ON o.order_id = p.order_id
GROUP BY o.customer_id;

-- Repeat Customers
SELECT customer_id, COUNT(order_id) AS orders_count
FROM orders
GROUP BY customer_id
HAVING COUNT(order_id) > 1;
