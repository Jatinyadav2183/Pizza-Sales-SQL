-- Determine the top 3 most ordered pizza types based on revenue for each pizza category. 
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