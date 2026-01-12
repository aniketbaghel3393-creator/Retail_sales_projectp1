CREATE DATABASE sql_retail_p1;

CREATE TABLE Retail_sales(

transactions_id INT PRIMARY KEY,
sale_date DATE, 
sale_time TIME,
customer_id INT,
gender VARCHAR(15),
age INT,
category VARCHAR(15),
quantity INT,
price_per_unit FLOAT,
cogs FLOAT,
total_sale FLOAT

);

SELECT * FROM Retail_sales
LIMIT 10;

SELECT COUNT(*) FROM 
retail_sales;

--DATA CLEANING

SELECT * FROM Retail_sales 
WHERE transactions_id IS NULL;


SELECT *  FROM Retail_sales 
WHERE transactions_id IS NULL 
OR 
sale_date IS NULL
OR 
customer_id IS NULL
OR 
gender IS NULL
OR 
age IS NULL
OR 
category IS NULL
OR
quantity IS NULL
OR 
price_per_unit IS NULL
OR 
cogs IS NULL
OR 
total_sale IS NULL;

--DATA  EXPLORATION

--HOW MANY SALES WE HAVE?

SELECT COUNT(*) AS total_sale
FROM Retail_sales;

--HOW MANY UNIQUE CUSTOMER WE HAVE?

SELECT COUNT(DISTINCT customer_id) as total_sale
FROM Retail_sales;

SELECT DISTINCT category FROM Retail_sales;

--DATA ANALYSIS AND SOLVE BUSINESS PROBLEM IN PROJECT;

--Q1 Write a SQL query to retrieve all column for sales mode on '2022-11-05'

SELECT * FROM Retail_sales
WHERE sale_date = '2022-11-05';

--Q2 Write a SQL query to retrieve all transactions where the category is 'CLothing' and the quantity sold is more than 10
--in the month nov-2022.

SELECT *
 FROM Retail_sales
 WHERE Category = 'Clothing'
 AND 
 TO_CHAR(sale_date, 'yyyy-mm') = '2022-11'
 AND 
 quantity >= 4;
 

 
 --Q3 Write a SQL query to calculate the total sales (total_sale) for each category?

 SELECT 
  category,
  SUM(total_sale)
FROM Retail_sales 
GROUP BY category;
 
--Q4 Write SQL query to find the average age of customers who purchased items from the 'Beauty' category.
 
SELECT 
  ROUND(AVG(age),2) as Avg_age
  FROM Retail_sales 
  WHERE category = 'Beauty';

--Q5 Write SQL query to find all tranactions where the total_sale is greater than 1000.

SELECT * 
FROM Retail_sales 
WHERE total_sale > 1000;

--Q6 Write SQL query to find the total number of tranactions (transactions_id) made by each gender in each category.

SELECT 
   category,
   gender,
   COUNT(*) AS total_trans
FROM Retail_sales
GROUP BY category,gender
ORDER BY 1;

-- Q7 Write a SQL query to calculate the average sale for each month. find out best selling month in each year.

SELECT      
    Year,
	Month,
	Avg_total_sale
FROM 
(
SELECT 
   EXTRACT(Year FROM Sale_date) as Year,
   EXTRACT(Month FROM Sale_date) as Month,
   AVG(total_sale) as Avg_total_sale,
   RANK() OVER(PARTITION BY EXTRACT(Year FROM Sale_date) ORDER BY AVG(total_sale) DESC) as rank

FROM 
  Retail_sales 
GROUP BY 
 Year, Month
) as t1
WHERE rank = 1;


-- Q8 Write a SQL query to find top 5 customers based on the highest total sales.

SELECT 
   customer_id,
   SUM(total_sale) as total_sales
FROM Retail_sales 
GROUP BY customer_id
ORDER BY total_sales DESC
LIMIT 5;
  

 --Q9 Write a SQL query to find the number of unique customers who purchased items from each category.

SELECT    
   category,
   COUNT(DISTINCT customer_id) AS Unique_Customers
FROM Retail_sales
GROUP BY  Category;

--Q10 Write a SQL query to Create each shift and number of order (Example Morning <= 12. Afternoon Between 12 & 17, Evening < 17). 


WITH Hourly_Sale
AS 
(
SELECT *,
   CASE
        WHEN EXTRACT(HOUR FROM sale_time) < 12 THEN 'Morning'
        WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
		ELSE 'Evening'
		END AS Shift 

	 FROM Retail_sales 
) 

SELECT 
   Shift,
COUNT(*) as total_orders 
FROM Hourly_Sale
GROUP BY Shift;
   

--END OF THE PROJECT--
	 


		
 

 



