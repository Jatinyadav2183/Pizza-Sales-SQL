-- Analyze the cumulative revenue generated over time.

select order_date , round(sum(revenue) over (order by order_date),0) from
(select (orders.order_date), round(sum(order_details.quantity*pizzas.price),2) as revenue
from orders join order_details on order_details.order_id = orders.order_id 
join pizzas on order_details.pizza_id = pizzas.pizza_id
group by orders.order_date) as sales;