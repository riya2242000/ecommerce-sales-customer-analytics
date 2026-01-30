-- Project: E-Commerce Sales & Customer Analytics
-- Purpose: Create database schema for sales and customer analysis

-- Customers table stores unique customer information
-- Used to analyze customer behavior, retention, and lifetime value
CREATE TABLE customers (
    customer_id VARCHAR(50),
    customer_city VARCHAR(50),
    customer_state VARCHAR(10)
);

-- Orders table stores order-level transaction data
-- Used for order volume, revenue trends, and time-based analysis
CREATE TABLE orders (
    order_id VARCHAR(50),
    customer_id VARCHAR(50),
    order_status VARCHAR(20),
    order_purchase_timestamp TIMESTAMP
);

-- Order_items table stores product-level details for each order
-- Used to calculate product sales, quantities, and revenue contribution
CREATE TABLE order_items (
    order_id VARCHAR(50),
    product_id VARCHAR(50),
    price FLOAT
);

-- Payments table stores payment and revenue details
-- Used to calculate total revenue, average order value, and CLV
CREATE TABLE payments (
    order_id VARCHAR(50),
    payment_value FLOAT
);

-- Products table stores product category information
-- Used for product-level sales and category performance analysis
CREATE TABLE products (
    product_id VARCHAR(50),
    product_category VARCHAR(50)
);
