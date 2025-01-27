create database pizza_sales;
use pizza_sales;
create table order_details(
order_details_id INT,
order_id INT,
pizza_id TEXT, 
quantity INT
);
SHOW VARIABLES LIKE 'secure_file_priv';
SET GLOBAL local_infile = 1;
load data infile 'C:/ProgramData/MySQL/MySQL Server 8.0/Data/pizza_sales/order_details.csv' into table order_details
fields terminated by ','
lines terminated by '\n'
ignore 1 lines;

create table orders(
order_id INT, 
order_date DATE,
order_time TIME
);

load data infile 'C:/ProgramData/MySQL/MySQL Server 8.0/Data/pizza_sales/orders.csv' 
into table orders
fields terminated by ','
lines terminated by '\n'
ignore 1 lines;

create table pizza_types(
pizza_type_id TEXT,
name_of_pizza TEXT,
category TEXT, 
ingredients TEXT
);

create table pizzas(
pizza_id TEXT,
pizza_type_id TEXT,
size TEXT,
price double
);