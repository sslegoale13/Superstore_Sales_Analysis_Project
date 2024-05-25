SET sql_safe_updates = 0;

SET sql_mode = "Traditional";

-- Superstore Sales Initial Data Analysis.

CREATE DATABASE superstore_sales;

-- Imported Superstore Sales data into MySQL using SQLAlchemy.

USE superstore_sales;

SELECT *
FROM orders;

-- 1. Removing Duplicates

SELECT `COLUMN_NAME`
FROM `INFORMATION_SCHEMA`.`COLUMNS`
WHERE `TABLE_SCHEMA` = "superstore_sales"
AND `TABLE_NAME` = "orders";

WITH Duplicates_CTE AS (
SELECT *,
ROW_NUMBER() OVER(
PARTITION BY
`Order ID`,
`Order Date`,
`Ship Date`,
`Ship Mode`,
`Customer ID`,
`Customer Name`,
`Segment`,
`Country/Region`,
`City`,
`State/Province`,
`Postal Code`,
`Region`,
`Product ID`,
`Category`,
`Sub-Category`,
`Product Name`,
`Sales`,
`Quantity`,
`Discount`,
`Profit`) AS "Row Number"
FROM orders)
SELECT *
FROM Duplicates_CTE
WHERE `Row Number` > 1;

SELECT *
FROM orders
WHERE `Order ID` = "CA-2019-153623";

SELECT *
FROM orders
WHERE `Order ID` = "US-2019-150119";

DELETE
FROM orders
WHERE `Row ID` IN (1699, 392);

SELECT *
FROM orders
WHERE `Row ID` = 1699;

SELECT *
FROM orders
WHERE `Row ID` = 392;

-- 2. Data Formatting & Standardisation

DESCRIBE orders;

SELECT count(DISTINCT `Row ID`)
FROM orders;

SELECT DISTINCT `Order ID`
FROM orders;

SELECT DISTINCT `Order Date`
FROM orders;

SELECT `Order Date`,
date_format(str_to_date(`Order Date`, "%m/%d/%Y"), "%Y/%m/%d")
FROM orders;

UPDATE orders
SET `Order Date` = date_format(str_to_date(`Order Date`, "%m/%d/%Y"), "%Y/%m/%d");

ALTER TABLE orders
MODIFY COLUMN `Order Date` DATE;

SELECT DISTINCT `Ship Date`
FROM orders;

SELECT `Ship Date`,
date_format(str_to_date(`Order Date`, "%Y-%m-%d"), "%Y/%m/%d")
FROM orders;

UPDATE orders
SET `Ship Date` = date_format(str_to_date(`Order Date`, "%Y-%m-%d"), "%Y/%m/%d");

ALTER TABLE orders
MODIFY COLUMN `Ship Date` DATE;

SELECT DISTINCT `Ship Mode`
FROM orders;

SELECT DISTINCT `Customer ID`
FROM orders;

SELECT DISTINCT `Customer Name`
FROM orders;

SELECT DISTINCT `Segment`
FROM orders;

SELECT DISTINCT `Country/Region`
FROM orders;

SELECT DISTINCT `City`
FROM orders;

SELECT DISTINCT `State/Province`
FROM orders;

SELECT DISTINCT `Postal Code`
FROM orders;

SELECT DISTINCT `Region`
FROM orders;

SELECT DISTINCT `Product ID`
FROM orders;

SELECT DISTINCT `Category`
FROM orders;

SELECT `Category`,
`Product Id`
FROM orders
WHERE `Product Id` LIKE "OFF%";

SELECT DISTINCT `Sub-Category`
FROM orders;

SELECT `Category`,
`Sub-Category`
FROM orders
GROUP BY `Sub-Category`;

SELECT DISTINCT `Product Name`
FROM orders;

SELECT DISTINCT `Sales`
FROM orders;

SELECT DISTINCT `Quantity`
FROM orders;

SELECT DISTINCT `Discount`
FROM orders;

SELECT DISTINCT `Profit`
FROM orders;