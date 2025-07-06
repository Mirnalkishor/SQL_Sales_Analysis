
-- Retail Sales SQL Project (MySQL Compatible, Table: Retail_Table)

-- Quick Data Preview
select * from Retail_Table limit 10;

-- Count Total Transactions
select count(*) as total_transactions from Retail_Table;

-- Data Cleaning Checks
select * from Retail_Table where sale_date is null;
select * from Retail_Table where sale_time is null;

-- Combined Null Checks
select * 
from Retail_Table
where 
    sale_date is null
    or sale_time is null
    or gender is null
    or category is null
    or quantiy is null
    or cogs is null
    or total_sale is null;

-- Total Sales Count
select count(*) as total_sales from Retail_Table;

-- Unique Customers
select count(distinct customer_id) as unique_customers from Retail_Table;

-- Distinct Product Categories
select distinct category from Retail_Table;

-- Business Questions & SQL Analysis

-- Q1: Sales made on 2022-11-05
select * from Retail_Table where sale_date = '2022-11-05';

-- Q2: Clothing sales with quantity over 4 in Nov-2022
select * 
from Retail_Table
where 
    category = 'Clothing'
    and date_format(sale_date, '%Y-%m') = '2022-11'
    and quantiy > 4;

-- Q3: Total sales by category
select 
    category,
    sum(total_sale) as total_sales,
    count(*) as total_orders
from Retail_Table
group by category;

-- Q4: Average age of 'Beauty' category customers
select round(avg(age), 2) as average_age 
from Retail_Table 
where category = 'Beauty';

-- Q5: Transactions with total_sale greater than 1000
select * from Retail_Table where total_sale > 1000;

-- Q6: Total transactions by gender and category
select 
    category,
    gender,
    count(*) as total_transactions
from Retail_Table
group by category, gender
order by category;

-- Q7: Best-selling month for each year
select 
    year,
    month,
    avg_sale
from (
    select 
        year(sale_date) as year,
        month(sale_date) as month,
        avg(total_sale) as avg_sale,
        rank() over (partition by year(sale_date) order by avg(total_sale) desc) as sales_rank
    from Retail_Table
    group by year, month
) ranked_months
where sales_rank = 1;

-- Q8: Top 5 customers by total sales
select 
    customer_id,
    sum(total_sale) as total_sales
from Retail_Table
group by customer_id
order by total_sales desc
limit 5;

-- Q9: Unique customers by category
select 
    category,
    count(distinct customer_id) as unique_customers
from Retail_Table
group by category;

-- Q10: Orders by shift (morning, afternoon, evening)
with sales_by_shift as (
    select *,
        case
            when hour(sale_time) < 12 then 'Morning'
            when hour(sale_time) between 12 and 17 then 'Afternoon'
            else 'Evening'
        end as shift
    from Retail_Table
)
select 
    shift,
    count(*) as total_orders
from sales_by_shift
group by shift;

-- End of MySQL-Compatible SQL Project
