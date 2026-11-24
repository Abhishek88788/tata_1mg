USE tata1mg_db;

/*
List the top 10 cities by number of orders, with
each city's % share off all orders.
*/

-- SELECT *
-- FROM orders
-- JOIN customers USING(customer_id)
-- JOIN cities USING(city_id);

SET sql_mode = 'PIPES_AS_CONCAT';

-- with t1 AS (SELECT city_name,COUNT(order_id) no_of_orders
-- FROM orders
-- JOIN customers USING(customer_id)
-- JOIN cities USING(city_id)
-- GROUP BY city_id
-- ORDER BY no_of_orders DESC
-- LIMIT 10);

-- SELECT  city_name, no_of_orders,
-- ROUND(no_of_orders*100 / sum(no_of_orders) OVER(),2) || '%' as percent_share
-- FROM t1;

SELECT city_name,COUNT(order_id) no_of_orders,
ROUND(COUNT(order_id)*100 / sum(COUNT(order_id)) OVER(),2) || '%' as percent_share
FROM orders
JOIN customers USING(customer_id)
JOIN cities USING(city_id)
GROUP BY city_id
ORDER BY no_of_orders DESC
LIMIT 10

