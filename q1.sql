USE tata1mg_db;

select SUM(order_id),count(order_id)
from orders
WHERE order_status = "Delivered" AND YEAR(order_datetime) = 2026 AND MONTH(order_datetime) = 10;

SELECT 
    COUNT(order_id) AS total_orders,
    COUNT(CASE WHEN order_status = 'Delivered' THEN 1 END) AS delivered_orders,
    ROUND(SUM(CASE WHEN order_status = 'Delivered' THEN order_value ELSE 0 END), 2) AS revenue,
    ROUND(AVG(CASE WHEN order_status = 'Delivered' THEN order_value END), 2) AS average_order_value
FROM orders
WHERE order_datetime >= '2026-10-01' 
  AND order_datetime < '2026-11-01';
