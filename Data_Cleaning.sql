-- This is my data set https://www.kaggle.com/datasets/braniac2000/retail-dataset
CREATE DATABASE sales_data;
USE sales_data;
RENAME TABLE `capstone1c_euromart stores-1` TO orders;

-- Creating duplicate of orginal dataset
CREATE TABLE orders_staging
LIKE orders;
INSERT orders_staging
SELECT * FROM orders;

SELECT * FROM orders_staging;

-- DATA CLEANING
-- 1. Removing duplicates
CREATE TABLE `orders_staging2` (
  `Order_ID` text,
  `Order Date` text,
  `Customer Name` text,
  `Country` text,
  `State` text,
  `City` text,
  `Region` text,
  `Segment` text,
  `Ship Mode` text,
  `Category` text,
  `Sub-Category` text,
  `Product Name` text,
  `Discount` text,
  `Sales` text,
  `Profit` text,
  `Quantity` int DEFAULT NULL,
  `Feedback?` text,
  `row_num` int
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO orders_staging2
(
SELECT *,
ROW_NUMBER() OVER(
PARTITION BY `ï»¿Order ID`, 'Order Date', 'Customer Name', 'Sub-Category', Discount, Sales, Profit, Quantity) AS row_num
FROM orders
);

SELECT * FROM orders_staging2
WHERE row_num >1;

DELETE 
FROM orders_staging2
WHERE row_num >1;

-- 2. Standardizing Data
UPDATE orders_staging2
SET `Order Date` = str_to_date(`ORDER DATE`, '%m/%d/%Y');

ALTER TABLE orders_staging2
MODIFY COLUMN `Order Date` DATE;

UPDATE orders_staging2
SET Discount =replace(Discount,'$','');

UPDATE orders_staging2
SET Sales =replace(Sales,'$','');
UPDATE orders_staging2
SET Sales = replace(Sales,',','');

UPDATE orders_staging2
SET Profit = replace(Profit,'$','');
UPDATE orders_staging2
SET Profit = replace(Profit,',','');

DELETE FROM orders_Staging2 WHERE Profit=' -   ';

ALTER TABLE orders_staging2
MODIFY COLUMN Discount FLOAT,
MODIFY COLUMN Profit INT,
MODIFY COLUMN Sales INT
;
SELECT * FROM orders_staging2;

-- 3. Removing NULL or Blank values
UPDATE orders_staging2
SET Discount = '0'
WHERE Discount = ' -   ';

-- 4. Creating and removing columns
SELECT 
`Order Date`,
Order_ID,
`Customer Name`,
Country,
`Ship Mode`,
Category,
`Sub-Category`,
`Product Name`,
Quantity,
ROUND(Sales + (Discount * Quantity), 2) AS `Pre-Discounted Sales`,
ROUND(Discount * Quantity, 2) AS `Total Discount`,
Sales,
Profit
FROM Orders_staging2;