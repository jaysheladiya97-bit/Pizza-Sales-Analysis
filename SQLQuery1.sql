
-- for total_revenu kpi
SELECT SUM(total_price) as Total_Revenu 
from pizza_sales

select * from pizza_sales

-- for avg_order_amount
select sum(total_price) / count(distinct order_id) as avg_order_value 
from pizza_sales

--for total_pizza sold
select sum(quantity) as total_pizza_sold
from pizza_sales

--for total order
select count(distinct order_id) as Total_order
from pizza_sales

--for avg_pizza_order cast is used for get op in decimal
select cast(cast(sum(quantity)as decimal(10,2)) / 
cast(count(distinct order_id)as decimal(10,2))as decimal(10,2)) as Avg_Pizza_Order
from pizza_sales

-- for find the day wise total order's by sir alphabetical order
 select datename(dw , order_date) as order_day , count(distinct order_id) as Total_orders
 from pizza_sales
 group by datename(dw , order_date)

--also same as but in a day order
SELECT 
    DATENAME(WEEKDAY, order_date) AS order_day,
    COUNT(DISTINCT order_id) AS total_orders
FROM pizza_sales
GROUP BY DATENAME(WEEKDAY, order_date),
         DATEPART(WEEKDAY, order_date)
ORDER BY DATEPART(WEEKDAY, order_date)

-- Hourly tred 
SELECT 
    DATEPART(HOUR, ORDER_TIME) AS ORDER_HOURS, COUNT(DISTINCT ORDER_ID) AS TOTAL_ORDERS
FROM pizza_sales
GROUP BY DATEPART(HOUR , ORDER_TIME)
ORDER BY DATEPART(HOUR , ORDER_TIME)

--DATE WISE PROFIT IN % OR TOTAL
SELECT PIZZA_CATEGORY,
    SUM(TOTAL_PRICE) AS TOTAL_SALES, SUM(TOTAL_PRICE) * 100 / 
    (SELECT SUM(TOTAL_PRICE) FROM pizza_sales) AS TOTAL_PCT 
FROM pizza_sales
GROUP BY pizza_category

--PIZZA SIZE WISE % OR TOTAL
SELECT PIZZA_SIZE,
    CAST(SUM(TOTAL_PRICE)AS DECIMAL(10,2)) AS TOTAL_SALES, CAST(SUM(TOTAL_PRICE) * 100 / 
    (SELECT SUM(TOTAL_PRICE) FROM pizza_sales WHERE DATEPART(QUARTER , ORDER_DATE) = 1)AS decimal(10,2)) AS TOTAL_PCT
FROM pizza_sales
WHERE DATEPART(QUARTER , ORDER_DATE) = 1
GROUP BY pizza_SIZE
ORDER BY TOTAL_PCT

--TOTAL PIZZA BY PIZZA CATEGORY
SELECT PIZZA_CATEGORY, SUM(QUANTITY) AS TOTAL_PIZZA_SOLD
FROM pizza_sales
GROUP BY pizza_category

--TOP 5 SELLER PIZZA SOLD
SELECT TOP 5 PIZZA_NAME, SUM(QUANTITY) AS TOTAL_PIZZA_SOLD
FROM pizza_sales
GROUP BY PIZZA_NAME
ORDER BY SUM(QUANTITY) DESC

--TOP 5 WORST SELLER PIZZA SOLD
SELECT TOP 5 PIZZA_NAME, SUM(QUANTITY) AS TOTAL_PIZZA_SOLD
FROM pizza_sales
GROUP BY PIZZA_NAME
ORDER BY SUM(QUANTITY)

