USE retail_sales_analysis;

-- ============================================================
-- 03_BUSINESS_ANALYSIS.SQL
-- Retail Sales Analytics
-- Purpose: Core business analysis and KPI queries
-- ============================================================

-- ============================================================
-- OVERALL BUSINESS PERFORMANCE
-- ============================================================

SELECT
    COUNT(*) AS total_sales_records,
    COUNT(DISTINCT order_id) AS total_orders,
    COUNT(DISTINCT customer_id) AS total_customers,
    SUM(quantity) AS total_units_sold,
    ROUND(SUM(sales), 2) AS total_sales,
    ROUND(SUM(profit), 2) AS total_profit,
    ROUND(SUM(profit) / SUM(sales) * 100, 2) AS profit_margin_pct
FROM retail_sales;

-- ============================================================
-- SALES AND PROFIT BY YEAR
-- ============================================================

SELECT
    YEAR(order_date) AS order_year,
    ROUND(SUM(sales), 2) AS total_sales,
    ROUND(SUM(profit), 2) AS total_profit,
    ROUND(SUM(profit) / SUM(sales) * 100, 2) AS profit_margin_pct
FROM retail_sales
GROUP BY YEAR(order_date)
ORDER BY order_year;

-- ============================================================
-- SALES AND PROFIT BY CATEGORY
-- ============================================================

SELECT
    category,
    ROUND(SUM(sales), 2) AS total_sales,
    ROUND(SUM(profit), 2) AS total_profit,
    SUM(quantity) AS total_units_sold,
    ROUND(SUM(profit) / SUM(sales) * 100, 2) AS profit_margin_pct
FROM retail_sales
GROUP BY category
ORDER BY total_sales DESC;

-- ============================================================
-- SALES AND PROFIT BY SUB-CATEGORY
-- ============================================================

SELECT
    sub_category,
    ROUND(SUM(sales), 2) AS total_sales,
    ROUND(SUM(profit), 2) AS total_profit,
    SUM(quantity) AS total_units_sold,
    ROUND(SUM(profit) / SUM(sales) * 100, 2) AS profit_margin_pct
FROM retail_sales
GROUP BY sub_category
ORDER BY total_profit DESC;

-- ============================================================
-- PROFITABILITY BY DISCOUNT LEVEL
-- ============================================================

SELECT
    discount,
    COUNT(*) AS sales_records,
    ROUND(SUM(sales), 2) AS total_sales,
    ROUND(SUM(profit), 2) AS total_profit,
    ROUND(SUM(profit) / SUM(sales) * 100, 2) AS profit_margin_pct
FROM retail_sales
GROUP BY discount
ORDER BY discount;

-- ============================================================
-- SUB-CATEGORY PROFITABILITY BY DISCOUNT
-- ============================================================

SELECT
    sub_category,
    discount,
    COUNT(*) AS sales_records,
    ROUND(SUM(sales), 2) AS total_sales,
    ROUND(SUM(profit), 2) AS total_profit,
    ROUND(SUM(profit) / SUM(sales) * 100, 2) AS profit_margin_pct
FROM retail_sales
GROUP BY
    sub_category,
    discount
ORDER BY
    sub_category,
    discount DESC;

-- ============================================================
-- BOTTOM 10 PRODUCTS BY PROFIT
-- ============================================================

SELECT
    product_name,
    category,
    sub_category,
    ROUND(SUM(sales), 2) AS total_sales,
    ROUND(SUM(profit), 2) AS total_profit,
    SUM(quantity) AS total_units_sold
FROM retail_sales
GROUP BY
    product_name,
    category,
    sub_category
ORDER BY total_profit ASC
LIMIT 10;

-- ============================================================
-- TOP 10 PRODUCTS BY PROFIT
-- ============================================================

SELECT
    product_name,
    category,
    sub_category,
    ROUND(SUM(sales), 2) AS total_sales,
    ROUND(SUM(profit), 2) AS total_profit,
    SUM(quantity) AS total_units_sold
FROM retail_sales
GROUP BY
    product_name,
    category,
    sub_category
ORDER BY total_profit DESC
LIMIT 10;

-- ============================================================
-- SALES AND PROFIT BY REGION
-- ============================================================

SELECT
    region,
    ROUND(SUM(sales), 2) AS total_sales,
    ROUND(SUM(profit), 2) AS total_profit,
    SUM(quantity) AS total_units_sold,
    ROUND(SUM(profit) / SUM(sales) * 100, 2) AS profit_margin_pct
FROM retail_sales
GROUP BY region
ORDER BY total_profit DESC;

-- ============================================================
-- PROFIT BY REGION AND CATEGORY
-- ============================================================

SELECT
    region,
    category,
    ROUND(SUM(sales), 2) AS total_sales,
    ROUND(SUM(profit), 2) AS total_profit,
    ROUND(SUM(profit) / SUM(sales) * 100, 2) AS profit_margin_pct
FROM retail_sales
GROUP BY
    region,
    category
ORDER BY
    region,
    total_profit DESC;

-- ============================================================
-- TOP 10 CUSTOMERS BY SALES
-- ============================================================

SELECT
    customer_name,
    segment,
    COUNT(DISTINCT order_id) AS total_orders,
    ROUND(SUM(sales), 2) AS total_sales,
    ROUND(SUM(profit), 2) AS total_profit
FROM retail_sales
GROUP BY
    customer_name,
    segment
ORDER BY total_sales DESC
LIMIT 10;

-- ============================================================
-- TOP 10 CUSTOMERS BY PROFIT
-- ============================================================

SELECT
    customer_name,
    segment,
    COUNT(DISTINCT order_id) AS total_orders,
    ROUND(SUM(sales), 2) AS total_sales,
    ROUND(SUM(profit), 2) AS total_profit
FROM retail_sales
GROUP BY
    customer_name,
    segment
ORDER BY total_profit DESC
LIMIT 10;

-- ============================================================
-- SALES AND PROFIT BY CUSTOMER SEGMENT
-- ============================================================

SELECT
    segment,
    COUNT(DISTINCT customer_id) AS total_customers,
    COUNT(DISTINCT order_id) AS total_orders,
    ROUND(SUM(sales), 2) AS total_sales,
    ROUND(SUM(profit), 2) AS total_profit,
    ROUND(SUM(profit) / SUM(sales) * 100, 2) AS profit_margin_pct
FROM retail_sales
GROUP BY segment
ORDER BY total_profit DESC;

-- ============================================================
-- SALES AND PROFIT BY SEGMENT AND CATEGORY
-- ============================================================

SELECT
    segment,
    category,
    ROUND(SUM(sales), 2) AS total_sales,
    ROUND(SUM(profit), 2) AS total_profit,
    ROUND(SUM(profit) / SUM(sales) * 100, 2) AS profit_margin_pct
FROM retail_sales
GROUP BY
    segment,
    category
ORDER BY
    segment,
    total_profit DESC;

-- ============================================================
-- SALES AND PROFIT BY REGION AND SEGMENT
-- ============================================================

SELECT
    region,
    segment,
    ROUND(SUM(sales), 2) AS total_sales,
    ROUND(SUM(profit), 2) AS total_profit,
    ROUND(SUM(profit) / SUM(sales) * 100, 2) AS profit_margin_pct
FROM retail_sales
GROUP BY
    region,
    segment
ORDER BY
    region,
    total_profit DESC;

-- ============================================================
-- MONTHLY SALES AND PROFIT
-- ============================================================

SELECT
    MONTH(order_date) AS month_number,
    MONTHNAME(order_date) AS month_name,
    ROUND(SUM(sales), 2) AS total_sales,
    ROUND(SUM(profit), 2) AS total_profit,
    ROUND(SUM(profit) / SUM(sales) * 100, 2) AS profit_margin_pct
FROM retail_sales
GROUP BY
    MONTH(order_date),
    MONTHNAME(order_date)
ORDER BY
    month_number;

-- ============================================================
-- AVERAGE ORDER VALUE (AOV)
-- ============================================================

SELECT
    COUNT(DISTINCT order_id) AS total_orders,
    ROUND(SUM(sales), 2) AS total_sales,
    ROUND(SUM(sales) / COUNT(DISTINCT order_id), 2) AS average_order_value
FROM retail_sales;

-- ============================================================
-- AVERAGE ORDER VALUE BY CUSTOMER SEGMENT
-- ============================================================

SELECT
    segment,
    COUNT(DISTINCT order_id) AS total_orders,
    ROUND(SUM(sales), 2) AS total_sales,
    ROUND(SUM(sales) / COUNT(DISTINCT order_id), 2) AS average_order_value
FROM retail_sales
GROUP BY segment
ORDER BY average_order_value DESC;

-- ============================================================
-- AVERAGE ORDER VALUE BY REGION
-- ============================================================

SELECT
    region,
    COUNT(DISTINCT order_id) AS total_orders,
    ROUND(SUM(sales), 2) AS total_sales,
    ROUND(SUM(sales) / COUNT(DISTINCT order_id), 2) AS average_order_value
FROM retail_sales
GROUP BY region
ORDER BY average_order_value DESC;

-- ============================================================
-- REPEAT VS ONE-TIME CUSTOMERS
-- ============================================================

SELECT
    customer_type,
    COUNT(*) AS total_customers,
    ROUND(SUM(total_sales), 2) AS total_sales,
    ROUND(AVG(total_sales), 2) AS average_customer_sales
FROM
(
    SELECT
        customer_id,
        CASE
            WHEN COUNT(DISTINCT order_id) = 1 THEN 'One-Time Customer'
            ELSE 'Repeat Customer'
        END AS customer_type,
        SUM(sales) AS total_sales
    FROM retail_sales
    GROUP BY customer_id
) AS customer_summary
GROUP BY customer_type
ORDER BY total_sales DESC;

-- ============================================================
-- CUSTOMER PROFITABILITY
-- ============================================================

SELECT
    customer_id,
    customer_name,
    segment,
    COUNT(DISTINCT order_id) AS total_orders,
    ROUND(SUM(sales), 2) AS total_sales,
    ROUND(SUM(profit), 2) AS total_profit,
    ROUND(SUM(profit) / SUM(sales) * 100, 2) AS profit_margin_pct
FROM retail_sales
GROUP BY
    customer_id,
    customer_name,
    segment
ORDER BY
    total_profit DESC;

-- ============================================================
-- LOSS-MAKING CUSTOMERS
-- ============================================================

SELECT
    customer_id,
    customer_name,
    segment,
    COUNT(DISTINCT order_id) AS total_orders,
    ROUND(SUM(sales), 2) AS total_sales,
    ROUND(SUM(profit), 2) AS total_profit,
    ROUND(SUM(profit) / SUM(sales) * 100, 2) AS profit_margin_pct
FROM retail_sales
GROUP BY
    customer_id,
    customer_name,
    segment
HAVING SUM(profit) < 0
ORDER BY
    total_profit ASC;

-- ============================================================
-- PRODUCT SALES AND PROFITABILITY
-- ============================================================

SELECT
    product_name,
    category,
    sub_category,
    ROUND(SUM(sales), 2) AS total_sales,
    ROUND(SUM(profit), 2) AS total_profit,
    ROUND(SUM(profit) / SUM(sales) * 100, 2) AS profit_margin_pct
FROM retail_sales
GROUP BY
    product_name,
    category,
    sub_category
HAVING SUM(sales) > 5000
ORDER BY
    profit_margin_pct ASC
LIMIT 10;

-- ============================================================
-- SHIPPING MODE PERFORMANCE
-- ============================================================

SELECT
    ship_mode,
    COUNT(DISTINCT order_id) AS total_orders,
    ROUND(SUM(sales), 2) AS total_sales,
    ROUND(SUM(profit), 2) AS total_profit,
    ROUND(SUM(profit) / SUM(sales) * 100, 2) AS profit_margin_pct
FROM retail_sales
GROUP BY ship_mode
ORDER BY total_profit DESC;

-- ============================================================
-- STATE-LEVEL SALES AND PROFITABILITY
-- ============================================================

SELECT
    state,
    COUNT(DISTINCT order_id) AS total_orders,
    ROUND(SUM(sales), 2) AS total_sales,
    ROUND(SUM(profit), 2) AS total_profit,
    ROUND(SUM(profit) / SUM(sales) * 100, 2) AS profit_margin_pct
FROM retail_sales
GROUP BY state
ORDER BY total_profit DESC;
