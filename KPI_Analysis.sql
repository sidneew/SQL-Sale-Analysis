-- KPIS AND ANALYSIS

--  1. Sales by year and month
SELECT YEAR(`Order Date`) AS `Year`, MONTH(`Order Date`) AS `Month`, SUM(Sales) as 	`Total Sales`, SUM(Profit) as `Total Profit`
FROM clean_orders
GROUP BY YEAR(`Order Date`), MONTH(`Order Date`)
ORDER BY YEAR(`Order Date`), MONTH(`Order Date`);

-- 2. Profit and sales by country
SELECT Country, SUM(Profit) AS `Total Profit`, SUM(Sales) AS `Total Sales`
FROM clean_orders
GROUP BY (Country);

-- 3. Number of orders shipped to each country
SELECT Country, COUNT(DISTINCT(Order_ID)) AS `Orders Placed`
FROM clean_orders
GROUP BY Country
ORDER BY `Orders Placed` DESC;

-- 4. Sales by subcategory
SELECT `Sub-Category`, SUM(SAles) AS `Total Sales`
FROM clean_orders
GROUP BY `Sub-Category`
ORDER BY `Total Sales` DESC;

-- 5. Count of Shipment Method
SELECT `Ship Mode` as `Shipment Method`, COUNT(`Ship Mode`) AS `Number of Orders`
FROM clean_orders
GROUP BY `Ship Mode`;

-- 6. Total sales and total profit
SELECT SUM(Profit) as Profit, SUM(Sales) as Sales
FROM clean_orders;