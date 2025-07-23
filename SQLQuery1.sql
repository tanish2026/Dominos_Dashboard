SELECT*FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_NAME ='pizza_sales'

USE Dominos

SELECT*FROM pizza_sales

SELECT SUM(total_price) AS TOTAL_REVENUE FROM pizza_sales

SELECT SUM(total_price)/COUNT(DISTINCT order_id) AS Avg_Order_value FROM pizza_sales

SELECT SUM(quantity) AS Total_Pizza_Sold FROM pizza_sales

SELECT COUNT (DISTINCT order_id) AS Total_order FROM pizza_sales

SELECT CAST(CAST( SUM(quantity) AS DECIMAL(10,2))/
CAST(COUNT(DISTINCT order_id)AS DECIMAL(10,2))AS DECIMAL(10,2)) AS Avg_pizzas_per_order FROM pizza_sales


---daily trend
SELECT DATENAME(DW, order_date) AS order_day,
       COUNT(DISTINCT order_id) AS Total_orders
FROM pizza_sales
GROUP BY DATENAME(DW, order_date)

---hourly trend
SELECT DATEPART(HOUR,order_time) AS order_hours, COUNT(DISTINCT order_id) AS Total_orders
FROM pizza_sales
GROUP BY DATEPART(HOUR,order_time)
ORDER BY DATEPART(HOUR,order_time)

--
SELECT pizza_category,SUM(total_price) AS Total_sales,sum(total_price)*100/
(SELECT sum(total_price) from pizza_sales WHERE MONTH(order_date)= 1) as Percentage_of_Total_sales
FROM pizza_sales
WHERE MONTH(order_date)= 1
GROUP BY pizza_category

--
SELECT pizza_size, CAST(SUM(total_price)AS DECIMAL (10,2)) AS Total_sales, CAST(SUM(total_price)*100/
(SELECT SUM(total_price) FROM pizza_sales WHERE DATEPART(quarter, order_date)=1) AS DECIMAL(10,2)) AS Percentage_of_Total_sales
FROM pizza_sales
WHERE DATEPART(quarter, order_date)=1
GROUP BY pizza_size
ORDER BY Percentage_of_Total_sales DESC

--
SELECT pizza_category, SUM(quantity) AS Total_pizzas_sold
FROM pizza_sales
GROUP BY pizza_category

--
SELECT TOP 5 pizza_name, SUM(quantity) AS Total_pizzas_sold
FROM pizza_sales
WHERE MONTH(order_date)=1
GROUP BY pizza_name
ORDER BY SUM(quantity) DESC