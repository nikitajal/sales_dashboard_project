-- =========================================
-- E-COMMERCE ORDERS DATA ANALYSIS
-- =========================================
-- Purpose: Perform data quality checks and
--          business analysis on e-commerce data
-- Role: Aspiring Data Analyst
-- =========================================


-- =========================================
-- 1. DATA QUALITY CHECKS
-- =========================================

-- Check for duplicate customers
SELECT
    customer_id,
    COUNT(*) AS duplicate_count
FROM customers
GROUP BY customer_id
HAVING COUNT(*) > 1;

-- Check for orders without valid customers
SELECT
    o.order_id
FROM orders o
LEFT JOIN customers c
    ON o.customer_id = c.customer_id
WHERE c.customer_id IS NULL;

-- Check for order items without valid orders
SELECT
    oi.order_id
FROM order_items oi
LEFT JOIN orders o
    ON oi.order_id = o.order_id
WHERE o.order_id IS NULL;

-- Order status distribution
SELECT
    order_status,
    COUNT(*) AS total_orders
FROM orders
GROUP BY order_status;


-- =========================================
-- 2. DATA UNDERSTANDING & BASIC BUSINESS METRICS
-- =========================================

-- Total number of orders
SELECT
    COUNT(*) AS total_orders
FROM orders;

-- Total number of customers
SELECT
    COUNT(*) AS total_customers
FROM customers;

-- Number of completed orders
SELECT
    COUNT(*) AS completed_orders
FROM orders
WHERE order_status = 'Completed';

-- Total revenue from completed orders
SELECT
    SUM(oi.quantity * oi.unit_price) AS total_revenue
FROM order_items oi
JOIN orders o
    ON oi.order_id = o.order_id
WHERE o.order_status = 'Completed';

-- Average order value (AOV)
SELECT
    SUM(oi.quantity * oi.unit_price) / COUNT(DISTINCT o.order_id) AS avg_order_value
FROM order_items oi
JOIN orders o
    ON oi.order_id = o.order_id
WHERE o.order_status = 'Completed';


-- =========================================
-- 3. BUSINESS ANALYSIS
-- =========================================

-- Top customers by total spend
SELECT
    c.customer_id,
    c.customer_name,
    SUM(oi.quantity * oi.unit_price) AS total_spent
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
JOIN order_items oi
    ON o.order_id = oi.order_id
WHERE o.order_status = 'Completed'
GROUP BY c.customer_id, c.customer_name
ORDER BY total_spent DESC;

-- Revenue by product category
SELECT
    oi.category,
    SUM(oi.quantity * oi.unit_price) AS category_revenue
FROM order_items oi
JOIN orders o
    ON oi.order_id = o.order_id
WHERE o.order_status = 'Completed'
GROUP BY oi.category
ORDER BY category_revenue DESC;

-- Top selling products by quantity
SELECT
    oi.product_name,
    SUM(oi.quantity) AS total_units_sold
FROM order_items oi
JOIN orders o
    ON oi.order_id = o.order_id
WHERE o.order_status = 'Completed'
GROUP BY oi.product_name
ORDER BY total_units_sold DESC;

-- Monthly revenue trend
SELECT
    EXTRACT(MONTH FROM o.order_date) AS order_month,
    SUM(oi.quantity * oi.unit_price) AS monthly_revenue
FROM orders o
JOIN order_items oi
    ON o.order_id = oi.order_id
WHERE o.order_status = 'Completed'
GROUP BY order_month
ORDER BY order_month;

-- Repeat customers
SELECT
    c.customer_id,
    c.customer_name,
    COUNT(o.order_id) AS number_of_orders
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
WHERE o.order_status = 'Completed'
GROUP BY c.customer_id, c.customer_name
HAVING COUNT(o.order_id) > 1;
