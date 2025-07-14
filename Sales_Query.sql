---SQL retail sales Analysis-P1
CREATE DATABASE sql_project_project_p2;

--- create table
DROP TABLE IF EXISTS retail_sales;
create table retail_sales 
						(
						transactions_id INT,
						sale_date DATE,	
						sale_time TIME,	
						customer_id	INT,
						gender VARCHAR(15),
						age	INT,
						category VARCHAR(15),	
						quantity INT,	
						price_per_unit FLOAT,	
						cogs FLOAT,	
						total_sale FLOAT
						);

select * from retail_sales
LIMIT 50;


select COUNT(*) from retail_sales
LIMIT 50;

---

select * from retail_sales
where transactions_id is NULL

select * from retail_sales
where sale_date is NULL

----data cleaning 
select * from retail_sales
where transactions_id is NULL
or
      sale_date is NULL
or
      sale_time is NULL
or
      customer_id is NULL
or
      gender is NULL
or
      age is NULL
or
      category is NULL
or
      quantiy is NULL
or
      price_per_unit is NULL
or
      cogs is NULL
or
     total_sale is NULL;

delete from retail_sales
where transactions_id is NULL
or
      sale_date is NULL
or
      sale_time is NULL
or
      gender is NULL
or
      category is NULL
or
      quantiy is NULL
or
      cogs is NULL
or
     total_sale is NULL;


---Data exploration 

-----How many sales we have ?
select count(*) as Total_sale from retail_sales

-----How many uniquie customers we have ?
select count(distinct customer_id) as Total_sale from retail_sales

---------How many uniquie category we have ?
select distinct category from retail_sales

--- Data Analysis & business Key Problems ?

-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05

select  * from  retail_sales
where sale_date = '2022-11-05';

-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022
select * from  retail_sales
where category = 'Clothing'
AND 
quantity >= 4;
 
-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.

select category,
sum(total_sale) as Net_sales,
count(*) AS total_orders
from retail_sales
Group by category

-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.

select round(AVG (age),2) As average_age from retail_sales
where category ='Beauty'
-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.

select COUNT(*) from retail_sales
where total_sale > 1000
select * from retail_sales
where total_sale > 1000

-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
select  category,
        gender,
		count(*) as total_trans
		from retail_sales
		group by
		category,
		gender
order by category;

-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year



SELECT year, month, avg_sale
FROM (
    SELECT 
        EXTRACT(YEAR FROM sale_date) AS year,
        EXTRACT(MONTH FROM sale_date) AS month,
        SUM(total_sale) AS avg_sale,
        RANK() OVER (
            PARTITION BY EXTRACT(YEAR FROM sale_date)
            ORDER BY SUM(total_sale) DESC
        ) AS rank
    FROM retail_sales
    GROUP BY EXTRACT(YEAR FROM sale_date), EXTRACT(MONTH FROM sale_date)
) AS t1
WHERE rank = 1;



-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 

select 
customer_id,
SUM(total_sale) as total_sales
from retail_sales
group by customer_id
order by total_sales DESC
LIMIT 5
-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.

select 
category,
COUNT(DISTINCT customer_id) AS Unique_customer
from retail_sales
group by category


-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)

SELECT * from retail_sales

WITH hourly_sale 
AS
(SELECT *,
CASE 
WHEN EXTRACT(Hour from sale_time)< 12 then 'morning'
WHEN EXTRACT(Hour from sale_time)BETWEEN 12 and 17 then 'Afternoon'
ELSE 'Evening'
END as shift
from retail_sales
) 
select 
shift, 
COUNT(*) total_orders
from hourly_sale
group by shift


from retail_sales




