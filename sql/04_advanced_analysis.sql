-- ============================================================
-- 04_ADVANCED_ANALYSIS.SQL
-- Retail Sales Analytics
-- Purpose: Advanced SQL analysis using CTEs,
--          window functions, ranking, and conditional logic
-- ============================================================

USE retail_sales_analysis;


-- ============================================================
-- 26. TOP 3 MOST PROFITABLE PRODUCTS BY CATEGORY
-- Business Question:
-- Which products generate the most profit within each category?
-- ============================================================

WITH product_profit AS (
    SELECT
        category,
        product_name,
        ROUND(SUM(sales), 2) AS total_sales,
        ROUND(SUM(profit), 2) AS total_profit
    FROM retail_sales
    GROUP BY
        category,
        product_name
),

ranked_products AS (
    SELECT
        category,
        product_name,
        total_sales,
        total_profit,
        RANK() OVER (
            PARTITION BY category
            ORDER BY total_profit DESC
        ) AS profit_rank
    FROM product_profit
)

SELECT
    category,
    product_name,
    total_sales,
    total_profit,
    profit_rank
FROM ranked_products
WHERE profit_rank <= 3
ORDER BY
    category,
    profit_rank;


-- ============================================================
-- 27. TOP 5 PRODUCTS BY SALES WITHIN EACH CATEGORY
-- Business Question:
-- Which products generate the most sales within each category?
-- ============================================================

WITH product_sales AS (
    SELECT
        category,
        product_name,
        ROUND(SUM(sales), 2) AS total_sales
    FROM retail_sales
    GROUP BY
        category,
        product_name
),

ranked_products AS (
    SELECT
        category,
        product_name,
        total_sales,
        RANK() OVER (
            PARTITION BY category
            ORDER BY total_sales DESC
        ) AS sales_rank
    FROM product_sales
)

SELECT
    category,
    product_name,
    total_sales,
    sales_rank
FROM ranked_products
WHERE sales_rank <= 5
ORDER BY
    category,
    sales_rank;


-- ============================================================
-- 28. MONTHLY SALES WITH RUNNING TOTAL
-- Business Question:
-- How does cumulative sales grow over time?
-- ============================================================

WITH monthly_sales AS (
    SELECT
        YEAR(order_date) AS order_year,
        MONTH(order_date) AS month_number,
        MONTHNAME(order_date) AS month_name,
        ROUND(SUM(sales), 2) AS monthly_sales
    FROM retail_sales
    GROUP BY
        YEAR(order_date),
        MONTH(order_date),
        MONTHNAME(order_date)
)

SELECT
    order_year,
    month_number,
    month_name,
    monthly_sales,
    ROUND(
        SUM(monthly_sales) OVER (
            ORDER BY
                order_year,
                month_number
        ),
        2
    ) AS running_total_sales
FROM monthly_sales
ORDER BY
    order_year,
    month_number;


-- ============================================================
-- 29. YEAR-OVER-YEAR SALES GROWTH
-- Business Question:
-- How did total sales change compared with the previous year?
-- ============================================================

WITH yearly_sales AS (
    SELECT
        YEAR(order_date) AS order_year,
        ROUND(SUM(sales), 2) AS total_sales
    FROM retail_sales
    GROUP BY
        YEAR(order_date)
),

sales_comparison AS (
    SELECT
        order_year,
        total_sales,
        LAG(total_sales) OVER (
            ORDER BY order_year
        ) AS previous_year_sales
    FROM yearly_sales
)

SELECT
    order_year,
    total_sales,
    previous_year_sales,
    ROUND(
        (total_sales - previous_year_sales)
        / NULLIF(previous_year_sales, 0) * 100,
        2
    ) AS yoy_growth_pct
FROM sales_comparison
ORDER BY
    order_year;


-- ============================================================
-- 30. CATEGORY PROFIT CONTRIBUTION
-- Business Question:
-- What percentage of total company profit comes from each category?
-- ============================================================

WITH category_profit AS (
    SELECT
        category,
        ROUND(SUM(profit), 2) AS total_profit
    FROM retail_sales
    GROUP BY
        category
)

SELECT
    category,
    total_profit,
    ROUND(
        total_profit
        / NULLIF(SUM(total_profit) OVER (), 0) * 100,
        2
    ) AS profit_contribution_pct
FROM category_profit
ORDER BY
    total_profit DESC;


-- ============================================================
-- 31. TOP 5 MOST PROFITABLE CUSTOMERS BY SEGMENT
-- Business Question:
-- Who are the most profitable customers within each segment?
-- ============================================================

WITH customer_profit AS (
    SELECT
        segment,
        customer_id,
        customer_name,
        ROUND(SUM(sales), 2) AS total_sales,
        ROUND(SUM(profit), 2) AS total_profit
    FROM retail_sales
    GROUP BY
        segment,
        customer_id,
        customer_name
),

ranked_customers AS (
    SELECT
        segment,
        customer_id,
        customer_name,
        total_sales,
        total_profit,
        RANK() OVER (
            PARTITION BY segment
            ORDER BY total_profit DESC
        ) AS profit_rank
    FROM customer_profit
)

SELECT
    segment,
    customer_id,
    customer_name,
    total_sales,
    total_profit,
    profit_rank
FROM ranked_customers
WHERE profit_rank <= 5
ORDER BY
    segment,
    profit_rank;


-- ============================================================
-- 32. YEAR-OVER-YEAR SALES GROWTH BY CATEGORY
-- Business Question:
-- How did each category's sales change compared with the
-- previous year?
-- ============================================================

WITH yearly_category_sales AS (
    SELECT
        category,
        YEAR(order_date) AS order_year,
        ROUND(SUM(sales), 2) AS total_sales
    FROM retail_sales
    GROUP BY
        category,
        YEAR(order_date)
),

sales_comparison AS (
    SELECT
        category,
        order_year,
        total_sales,
        LAG(total_sales) OVER (
            PARTITION BY category
            ORDER BY order_year
        ) AS previous_year_sales
    FROM yearly_category_sales
)

SELECT
    category,
    order_year,
    total_sales,
    previous_year_sales,
    ROUND(
        (total_sales - previous_year_sales)
        / NULLIF(previous_year_sales, 0) * 100,
        2
    ) AS yoy_growth_pct
FROM sales_comparison
ORDER BY
    category,
    order_year;


-- ============================================================
-- 33. PRODUCTS WITH MULTIPLE LOSS-MAKING SALES RECORDS
-- Business Question:
-- Which products have at least three loss-making sales records?
-- ============================================================

SELECT
    product_name,
    category,
    sub_category,
    COUNT(DISTINCT YEAR(order_date)) AS years_sold,
    SUM(
        CASE
            WHEN profit < 0 THEN 1
            ELSE 0
        END
    ) AS loss_records,
    ROUND(SUM(sales), 2) AS total_sales,
    ROUND(SUM(profit), 2) AS total_profit
FROM retail_sales
GROUP BY
    product_name,
    category,
    sub_category
HAVING
    SUM(
        CASE
            WHEN profit < 0 THEN 1
            ELSE 0
        END
    ) >= 3
ORDER BY
    total_profit ASC;


-- ============================================================
-- 34. HIGH-SALES PRODUCTS WITH LOW PROFIT MARGINS
-- Business Question:
-- Which products generate significant sales but have poor margins?
-- ============================================================

WITH product_performance AS (
    SELECT
        product_name,
        category,
        sub_category,
        ROUND(SUM(sales), 2) AS total_sales,
        ROUND(SUM(profit), 2) AS total_profit,
        ROUND(
            SUM(profit)
            / NULLIF(SUM(sales), 0) * 100,
            2
        ) AS profit_margin_pct
    FROM retail_sales
    GROUP BY
        product_name,
        category,
        sub_category
),

ranked_products AS (
    SELECT
        product_name,
        category,
        sub_category,
        total_sales,
        total_profit,
        profit_margin_pct,
        RANK() OVER (
            ORDER BY profit_margin_pct ASC
        ) AS margin_rank
    FROM product_performance
    WHERE total_sales >= 5000
)

SELECT
    product_name,
    category,
    sub_category,
    total_sales,
    total_profit,
    profit_margin_pct,
    margin_rank
FROM ranked_products
ORDER BY
    margin_rank
LIMIT 10;


-- ============================================================
-- 35. YEARLY PROFIT WITH RUNNING TOTAL
-- Business Question:
-- How does cumulative profit grow over time?
-- ============================================================

WITH yearly_profit AS (
    SELECT
        YEAR(order_date) AS order_year,
        ROUND(SUM(profit), 2) AS total_profit
    FROM retail_sales
    GROUP BY
        YEAR(order_date)
)

SELECT
    order_year,
    total_profit,
    ROUND(
        SUM(total_profit) OVER (
            ORDER BY order_year
        ),
        2
    ) AS running_total_profit
FROM yearly_profit
ORDER BY
    order_year;


-- ============================================================
-- 36. CUSTOMER SALES CONTRIBUTION
-- Business Question:
-- How much does each top customer contribute to total sales?
-- ============================================================

WITH customer_sales AS (
    SELECT
        customer_id,
        customer_name,
        ROUND(SUM(sales), 2) AS total_sales
    FROM retail_sales
    GROUP BY
        customer_id,
        customer_name
)

SELECT
    customer_id,
    customer_name,
    total_sales,
    ROUND(
        total_sales
        / NULLIF(SUM(total_sales) OVER (), 0) * 100,
        2
    ) AS sales_contribution_pct
FROM customer_sales
ORDER BY
    total_sales DESC
LIMIT 20;


-- ============================================================
-- 37. TOP 10 CUSTOMERS BY PROFIT PER ORDER
-- Business Question:
-- Which customers generate the most profit per order?
-- ============================================================

WITH customer_metrics AS (
    SELECT
        customer_id,
        customer_name,
        segment,
        COUNT(DISTINCT order_id) AS total_orders,
        ROUND(SUM(sales), 2) AS total_sales,
        ROUND(SUM(profit), 2) AS total_profit
    FROM retail_sales
    GROUP BY
        customer_id,
        customer_name,
        segment
)

SELECT
    customer_id,
    customer_name,
    segment,
    total_orders,
    total_sales,
    total_profit,
    ROUND(
        total_profit
        / NULLIF(total_orders, 0),
        2
    ) AS profit_per_order
FROM customer_metrics
WHERE total_orders >= 2
ORDER BY
    profit_per_order DESC
LIMIT 10;