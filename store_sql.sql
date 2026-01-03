create database super_stores;
use super_stores;
-- 1.	Display the first 10 records from the stores table.
select * from stores limit 10 ;
select Category, sum(Sales) from stores
group by Category;
-- 2.	How many total records are present in the dataset?
select count(*) from stores;
-- 3.	What is the total sales value?
select sum(Sales) from Stores;
-- 4.	What is the total profit generated?
select sum(Profit) from stores;
-- 5.	What is the total quantity of products sold?
select sum(Quantity) from stores;
-- 6.	List all unique product categories.
select distinct category from stores;
-- 7.	List all unique regions available in the dataset.
select distinct region from stores;
-- 8.	Show total sales by Category.
select category, sum(sales) from stores
group by category;
-- 9.	Show total profit by Category.
select category, sum(profit) from stores
group by category;
-- 10.	Show total sales by Region.
select region, sum(sales) from stores
group by region;
-- 11.	Show total sales by Sub-Category.
select `Sub-Category`, sum(sales) from stores
group by `Sub-Category`;
-- 12.	Which are the top 10 products by total sales?
select `Product Name`, sum(sales) as total_sales
from stores
group by `Product Name` 
order by total_sales desc
limit 10;
-- 13.	Which are the top 10 products by total profit?
select `Product Name` , sum(sales) from stores
group by `Product Name`
order by sum(sales) desc
limit 10;
-- 14.	Find total sales and profit for each Segment.
select segment,sum(sales), sum(profit) from stores
group by segment
show columns from stores;
-- 16.	Find total sales for each City. 
select city, sum(sales)
from stores
group by city;
-- 17.	Identify orders where profit is negative (loss)
SELECT `Order ID`, `Product Name`, `Sub-Category`, Profit
FROM stores
WHERE Profit < 0
ORDER BY Profit ASC;
-- 18.	Rank products based on total sales (highest to lowest).
select `product name`, sum(sales) from stores
group by `Product Name`
order by sum(sales) desc;
-- OR

SELECT 
    `Product Name`,
    SUM(Sales) AS total_sales,
    RANK() OVER (ORDER BY SUM(Sales) DESC) AS sales_rank
FROM stores
GROUP BY `Product Name`
ORDER BY sales_rank;

-- 19.	Rank sub-categories based on total profit within each category.
select `sub-category`, category, sum(profit),
rank() over(order by sum(profit) desc) as ranking
from stores
group by Category,`sub-category`
order by ranking ;
-- 20.	Calculate month-wise total sales.
select month(`order date`) as months, year(`order date`) as years, sum(sales) from stores
GROUP BY years, months
ORDER BY years, months;


SELECT 
    YEAR(`Order Date`) AS year,
    SUM(Sales) AS total_sales,
    SUM(SUM(Sales)) OVER (ORDER BY YEAR(`Order Date`)) AS cumulative_sales
FROM stores
GROUP BY year
ORDER BY year;
-- 21.	Calculate year-wise total sales.
SELECT 
    YEAR(`Order Date`) AS year,
    SUM(Sales) AS total_sales,
    SUM(Sales) - LAG(SUM(Sales)) OVER (ORDER BY YEAR(`Order Date`)) AS yoy_growth
FROM stores
GROUP BY year
ORDER BY year;

-- 22.	Find month-over-month sales growth.
SELECT 
  year,
  month,
  total_sales,
  total_sales - LAG(total_sales) 
    OVER (ORDER BY year, month) AS mom_growth
FROM (
  SELECT 
    YEAR(`order date`) AS year,
    MONTH(`order date`) AS month,
    SUM(sales) AS total_sales
  FROM stores
  GROUP BY YEAR(`order date`), MONTH(`order date`)
) t;

-- Identify the most profitable product in each region
SELECT region, `product name`, total_profit
FROM (
  SELECT 
    region,
    `product name`,
    SUM(profit) AS total_profit,
    RANK() OVER (PARTITION BY region ORDER BY SUM(profit) DESC) AS rnk
  FROM stores
  GROUP BY region, `product name`
) t
WHERE rnk = 1;




