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