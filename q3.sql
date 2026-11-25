USE tata1mg_db;

SELECT * from orders;
SELECT * FROM customers;
SELECT * FROM cities;

SET sql_mode = 'PIPES_AS_CONCAT';


 with cte1 AS (SELECT city_name, 
TIMESTAMPDIFF(MINUTE,order_datetime,delivered_datetime) as minutes_taken
FROM orders
JOIN customers USING(customer_id)
JOIN cities USING(city_id)
WHERE delivery_type = 'Express'
AND delivered_datetime IS NOT NULL)

-- SELECT city_name, SUM(minuts_taken > 60)/ count(minutes_taken) FROM cte1 ----> sum(boolean expresson) if there is true it count 1 
SELECT city_name,  count(minutes_taken) AS count_of_express_orders,  SUM(minutes_taken > 60) AS count_of_late_express_orders, ROUND((COUNT(case WHEN minutes_taken > 60 THEN 1 END) / count(minutes_taken))* 100,2) || '%' AS percent_of_late_express_orders
FROM cte1 
GROUP BY city_name
ORDER BY percent_of_late_express_orders;








