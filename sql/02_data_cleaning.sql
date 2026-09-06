USE retail_sales_analysis;

-- ============================================================
-- DATA QUALITY CHECKS
-- ============================================================

-- 1. Row count
SELECT
    COUNT(*) AS total_rows
FROM retail_sales;


-- 2. Row ID integrity
SELECT
    COUNT(DISTINCT row_id) AS unique_row_ids,
    MIN(row_id) AS min_row_id,
    MAX(row_id) AS max_row_id
FROM retail_sales;


-- 3. NULL value check
SELECT
    SUM(row_id IS NULL) AS null_row_id,
    SUM(order_id IS NULL) AS null_order_id,
    SUM(order_date IS NULL) AS null_order_date,
    SUM(ship_date IS NULL) AS null_ship_date,
    SUM(customer_id IS NULL) AS null_customer_id,
    SUM(product_id IS NULL) AS null_product_id,
    SUM(sales IS NULL) AS null_sales,
    SUM(quantity IS NULL) AS null_quantity,
    SUM(discount IS NULL) AS null_discount,
    SUM(profit IS NULL) AS null_profit
FROM retail_sales;


-- 4. Date range validation
SELECT
    MIN(order_date) AS earliest_order,
    MAX(order_date) AS latest_order
FROM retail_sales;


-- 5. Duplicate row ID check
SELECT
    row_id,
    COUNT(*) AS duplicate_count
FROM retail_sales
GROUP BY row_id
HAVING COUNT(*) > 1;


-- 6. Numeric value validation
SELECT
    COUNT(*) AS invalid_numeric_rows
FROM retail_sales
WHERE sales < 0
   OR quantity <= 0
   OR discount < 0
   OR discount > 1;


-- 7. Category validation
SELECT DISTINCT
    category
FROM retail_sales
ORDER BY category;


-- 8. Region validation
SELECT DISTINCT
    region
FROM retail_sales
ORDER BY region;


-- 9. Segment validation
SELECT DISTINCT
    segment
FROM retail_sales
ORDER BY segment;


-- 10. Shipping mode validation
SELECT DISTINCT
    ship_mode
FROM retail_sales
ORDER BY ship_mode;


-- ============================================================
-- DATA QUALITY SUMMARY
-- ============================================================

SELECT
    COUNT(*) AS total_rows,
    COUNT(DISTINCT order_id) AS unique_orders,
    COUNT(DISTINCT customer_id) AS unique_customers,
    SUM(sales) AS total_sales,
    SUM(profit) AS total_profit,
    AVG(sales) AS average_sales,
    AVG(profit) AS average_profit
FROM retail_sales;