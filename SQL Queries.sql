create database sqlprjct01;

create table orders (
order_id int not null,
order_date date not null,
order_time time not null,
primary key(order_id) );
-- The data is imported into the tables-- 

create table order_details (
order_details_id int not null,
order_id int not null,
pizza_id text not null,
quantity int not null,
primary key(order_details_id) ); 
-- The data is imported into the tables-- 

-- The tables pizzas and pizza_types are created during data importation--  
USE sqlprjct01;

-- Retrive the total number of orders placed-- 
select count(order_id) as total_orders from orders;

-- Caluclate the total revenue generated from pizzas--  

select round(sum(pizzas.price * order_details.quantity), 2) as revenue from 
order_details join pizzas on pizzas.pizza_id = order_details.pizza_id ;

-- Identify the highest-paid pizza-- 

select pizza_types.name, pizzas.price from pizza_types join pizzas on 
pizza_types.pizza_type_id = pizzas.pizza_type_id order by pizzas.price desc limit 1;

-- Identify the most common pizza size ordered

select pizzas.size, count(order_details.order_details_id) as order_count from pizzas join order_details on 
pizzas.pizza_id = order_details.pizza_id group by pizzas.size order by order_count desc limit 1; 

-- List the top 5 most ordered pizza types along with their quantities

select pizza_types.name, sum(order_details.quantity) as quantity from pizza_types join pizzas 
on pizza_types.pizza_type_id = pizzas.pizza_type_id join order_details 
on order_details.pizza_id = pizzas.pizza_id group by pizza_types.name order by quantity desc limit 5;

-- Join the necessary tables to find the total quantity of each pizza category

select pizza_types.name, sum(order_details.quantity) as quantity from pizza_types
join pizzas on pizza_types.pizza_type_id = pizzas.pizza_type_id join order_details
on order_details.pizza_id = pizzas.pizza_id group by pizza_types.name order by quantity desc limit 5;

-- Determine the distribution of orders by hour of the day

select hour(order_time) as hours, count(order_id) as order_count from orders group by hour(order_time);

-- Join the relevant tables to find the category wise distribution of pizzas.alter

select category, count(name) from pizza_types group by category;

-- Group the orders by date and caluclate the average number of pizzas ordered per day.

select round(avg(quantity), 0) from 
( select orders.order_date, sum(order_details.quantity) as quantity
from orders join order_details on orders.order_id = order_details.order_id 
group by orders.order_date) as order_quantity;

-- Determine the top 3 type of pizzas ordered based on the revenue 

select pizza_types.name, sum(order_details.quantity*pizzas.price) as revenue
from pizzas join pizza_types on pizzas.pizza_type_id = pizza_types.pizza_type_id join order_details 
on pizzas.pizza_id = order_details.pizza_id group by pizza_types.name order by revenue desc limit 3; 

-- Caluclate the percentage contribution of each pizza type to total revenue.

select pizza_types.category, sum(order_details.quantity*pizzas.price) / (select round(sum(pizzas.price * order_details.quantity), 2)
 as revenue from order_details join pizzas on pizzas.pizza_id = order_details.pizza_id) *100 as revenue
from pizza_types join pizzas on pizza_types.pizza_type_id = pizzas.pizza_type_id 
join order_details on order_details.pizza_id= pizzas.pizza_id 
group by pizza_types.category  order by revenue desc;
