
-- Business Objective:
-- To analyze and derive insights from pizza sales data to improve business decision-making. 
-- This includes understanding revenue trends, customer ordering behavior,
 -- and product performance to optimize sales and marketing strategies.

create database pizza;
use pizza;
select count(*) from pizza_sales;
select * from pizza_sales;


# Total Revenue
select sum(total_price) as Total_revenue  from pizza_sales;

#Average Order values
select sum(total_price) /count(distinct order_id) as Average_Order_Value from pizza_sales;

# Toatal Pizza Sold
select sum(quantity) as Total_Pizza_Sold from pizza_sales;

#Total Order Placed
select count(distinct order_id) as Total_Orders from pizza_sales;


# Average pizza per order
select round(sum(quantity)/count(distinct order_id),2) as Average_Pizza_Per_Order from pizza_sales;


# Daily trend for Total Orders
select dayname(str_to_date(order_date,'%d-%m-%Y')) as order_day,
 count(distinct order_id) as Total_Orders
 from pizza_sales
group by dayname(str_to_date(order_date,'%d-%m-%Y'));


# Hourly trend for Total Orders
select hour(order_time) as order_hours,
count(distinct order_id) as Total_Orders
 from pizza_sales
 group by hour(order_time)
 order by hour(order_time);
 
 # Percentage of Sales by Pizza Category for jan month
 select  pizza_category,
 sum(total_price) as total_sales,
 round((sum(total_price)*100/(select sum(total_price) from pizza_sales where month(str_to_date(order_date,'%d-%m-%Y'))=1)),2) as percentage_of_sales 
 from pizza_sales
 where month(str_to_date(order_date,'%d-%m-%Y'))=1
 group by  pizza_category;
 
 --
 select  pizza_category,
 sum(total_price) as total_sales,
 round((sum(total_price)*100/(select sum(total_price) from pizza_sales)),2) as percentage_of_sales 
 from pizza_sales
 group by  pizza_category;
 
 
 # Percentage of Sales by Pizza Size for jan month
  select  pizza_size,
 sum(total_price) as total_sales,
 round((sum(total_price)*100/(select sum(total_price) from pizza_sales where month(str_to_date(order_date,'%d-%m-%Y'))=1)),2) as percentage_of_sales 
 from pizza_sales
 where month(str_to_date(order_date,'%d-%m-%Y'))=1
 group by  pizza_size
 order by  percentage_of_sales desc;
 
 --
   select  pizza_size,
 sum(total_price) as total_sales,
 round((sum(total_price)*100/(select sum(total_price) from pizza_sales )),2) as percentage_of_sales 
 from pizza_sales
 group by  pizza_size
 order by  percentage_of_sales desc;
 
 --
   select  pizza_size,
 sum(total_price) as total_sales,
 round((sum(total_price)*100/(select sum(total_price) from pizza_sales where month(str_to_date(order_date,'%d-%m-%Y'))=1)),2) as percentage_of_sales 
 from pizza_sales
 where month(str_to_date(order_date,'%d-%m-%Y'))=1
 group by  pizza_size
 order by  percentage_of_sales desc;
 

 #Total pizza Sold by Pizza Catagory
 select pizza_category,sum(quantity) as total_quantity_sold
 from pizza_sales
 group by 1;
 
 
 #Top 5 Pizza Seller by Total Pizza Sold
select pizza_name,total_quantity_sold from 
 (select *,dense_rank() over(order by total_quantity_sold desc ) as rnk from
(select pizza_name,sum(quantity) as total_quantity_sold
from pizza_sales
group by 1) temp )temp1 where rnk <=5;

#Bottom 5 Worst Pizza Seller by Total Pizza Sold;
select pizza_name,total_quantity_sold from 
 (select *,dense_rank() over(order by total_quantity_sold  ) as rnk from
(select pizza_name,sum(quantity) as total_quantity_sold
from pizza_sales
group by 1) temp )temp1 where rnk <=5;


 
 
 
 
 

