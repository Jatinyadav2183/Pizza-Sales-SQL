# Project Report: Pizza Sales Analysis Using SQL

# Introduction

The objective of this project was to analyze the performance and trends of a pizza sales business using SQL. By querying the database, we aimed to derive insights about order volumes, revenue generation, customer preferences, and sales patterns. The findings from the analysis can help in making data-driven

## Basic Analysis
  
  1. Retrieve the total number of orders placed.

    select count(order_id) as total_orders from orders;
  
  2. Calculate the total revenue generated from pizza sales.

    SELECT 
    ROUND(SUM(order_details.quantity * pizzas.price),
            2) AS total_sales
    FROM
        order_details
            JOIN
        pizzas ON pizzas.pizza_id = order_details.pizza_id
  
  3. Identify the highest-priced pizza.

    SELECT 
        pizza_types.name_of_pizza, pizzas.price
    FROM
        pizza_types
            JOIN
        pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
    ORDER BY pizzas.price DESC
    LIMIT 1;
  
  4. Identify the most common pizza size ordered.

  
  
  5. List the top 5 most ordered pizza types along with their quantities.

    SELECT 
        pizza_types.name_of_pizza,
        SUM(order_details.quantity) AS quantity
    FROM
        pizza_types
            JOIN
        pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
            JOIN
        order_details ON order_details.pizza_id = pizzas.pizza_id
    GROUP BY pizza_types.name_of_pizza
    ORDER BY quantity DESC
    LIMIT 5;


## Intermediate Question:
  
  1. Join the necessary tables to find the total quantity of each pizza category ordered.

    SELECT 
        pizza_types.category,
        SUM(order_details.quantity) AS total_quantity
    FROM
        pizza_types
            JOIN
        pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
            JOIN
        order_details ON order_details.pizza_id = pizzas.pizza_id
    GROUP BY pizza_types.category
    ORDER BY total_quantity DESC; 
      
  2. Determine the distribution of orders by hour of the day.

    SELECT 
        HOUR(order_time) AS HOUR_f,
        COUNT(order_id) AS count_order_id
    FROM
        orders
    GROUP BY HOUR_f
    ORDER BY count_order_id DESC;
  
  3. Join relevant tables to find the category-wise distribution of pizzas.

    SELECT 
        pizza_types.category,
        COUNT(pizza_types.name_of_pizza) AS total_Count
    FROM
        pizza_types
    GROUP BY pizza_types.category
    ;
  
  4. Group the orders by date and calculate the average number of pizzas ordered per day.

    SELECT 
    ROUND(AVG(total_quantity), 0)
    FROM
    (SELECT 
        orders.order_date,
            SUM(order_details.quantity) AS total_quantity
    FROM
        orders
    JOIN order_details ON orders.order_id = order_details.order_id
    GROUP BY orders.order_date) AS quantity;
  
  5. Determine the top 3 most ordered pizza types based on revenue.

    select pizza_types.name_of_pizza , sum(order_details.quantity * pizzas.price) as revenue from 
    pizza_types join pizzas on pizza_types.pizza_type_id = pizzas.pizza_type_id join
    order_details on order_details.pizza_id = pizzas.pizza_id
    group by pizza_types.name_of_pizza 
    order by revenue desc limit 3;

## Advanced question:
  
  1. Calculate the percentage contribution of each pizza type to total revenue.

    SELECT 
        pizza_types.category,
        ROUND((ROUND(SUM(order_details.quantity * pizzas.price),
                        0)) / (SELECT 
                        SUM(order_details.quantity * pizzas.price)
                    FROM
                        order_details
                            JOIN
                        pizzas ON order_details.pizza_id = pizzas.pizza_id) * 100,
                2) AS revenue
    FROM
        pizza_types
            JOIN
        pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
            JOIN
        order_details ON order_details.pizza_id = pizzas.pizza_id
    GROUP BY pizza_types.category
    ORDER BY revenue DESC;
  
  2. Analyze the cumulative revenue generated over time.

    select order_date , round(sum(revenue) over (order by order_date),0) from
    (select (orders.order_date), round(sum(order_details.quantity*pizzas.price),2) as revenue
    from orders join order_details on order_details.order_id = orders.order_id 
    join pizzas on order_details.pizza_id = pizzas.pizza_id
    group by orders.order_date) as sales;
  
  3. Determine the top 3 most ordered pizza types based on revenue for each pizza category.

    select name_of_pizza,category, revenue, ra from
    (
    select category, name_of_pizza, revenue,
    rank() over (partition by category order by revenue desc) as ra 
    from
    
    (select pizza_types.category, pizza_types.name_of_pizza , round(sum(order_details.quantity*pizzas.price),0)
    as revenue
    from pizza_types join pizzas on pizza_types.pizza_type_id = pizzas.pizza_type_id 
    join order_details on order_details.pizza_id = pizzas.pizza_id
    group by pizza_types.category, pizza_types.name_of_pizza) as sale ) as b
    where ra <=3
    ;

# Conclusion

  The SQL-based analysis provided actionable insights into order patterns, revenue generation, and customer preferences. Key takeaways include identifying the most popular pizzas, peak order times, and revenue contributions across categories. These insights can help improve operational efficiency, optimize inventory, and tailor marketing strategies. Furthermore, advanced queries such as cumulative revenue analysis and category-wise rankings offer deeper business intelligence to support long-term growth and decision-making. By leveraging data-driven insights, the pizza business can maintain a competitive edge and drive sustainable success.

