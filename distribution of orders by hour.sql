-- Determine the distribution of orders by hour of the day.

SELECT 
    HOUR(order_time) AS HOUR_f,
    COUNT(order_id) AS count_order_id
FROM
    orders
GROUP BY HOUR_f
ORDER BY count_order_id DESC;