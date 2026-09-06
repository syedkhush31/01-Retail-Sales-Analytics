USE retail_sales_analysis;

LOAD DATA LOCAL INFILE 'C:/Users/sayed_lx0mv48/OneDrive/Desktop/Data-Analytics-Journey/Data-Analytics-Journey/01-Retail-Sales-Analytics/data/raw/superstore.csv'
INTO TABLE retail_sales
CHARACTER SET latin1
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(
    row_id,
    order_id,
    @order_date,
    @ship_date,
    ship_mode,
    customer_id,
    customer_name,
    segment,
    country,
    city,
    state,
    postal_code,
    region,
    product_id,
    category,
    sub_category,
    product_name,
    sales,
    quantity,
    discount,
    profit
)
SET
    order_date = STR_TO_DATE(@order_date, '%m/%d/%Y'),
    ship_date = STR_TO_DATE(@ship_date, '%m/%d/%Y');