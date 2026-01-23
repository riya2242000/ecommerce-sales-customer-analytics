CREATE TABLE customers (
    customer_id VARCHAR(50),
    customer_city VARCHAR(50),
    customer_state VARCHAR(10)
);

CREATE TABLE orders (
    order_id VARCHAR(50),
    customer_id VARCHAR(50),
    order_status VARCHAR(20),
    order_purchase_timestamp TIMESTAMP
);

CREATE TABLE order_items (
    order_id VARCHAR(50),
    product_id VARCHAR(50),
    price FLOAT
);

CREATE TABLE payments (
    order_id VARCHAR(50),
    payment_value FLOAT
);

CREATE TABLE products (
    product_id VARCHAR(50),
    product_category VARCHAR(50)
);
