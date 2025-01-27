-- Join relevant tables to find the category-wise distribution of pizzas.

SELECT 
    pizza_types.category,
    COUNT(pizza_types.name_of_pizza) AS total_Count
FROM
    pizza_types
GROUP BY pizza_types.category
;