USE tata1mg_db;

SELECT * from orders;
SELECT * FROM customers;
SELECT * FROM cities;

SELECT city_name, has_express,
COUNT(case WHEN delivery_type = 'Express' THEN 1 END) as count_of_express_orders
FROM orders
JOIN customers USING(customer_id)
JOIN cities USING(city_id)
WHERE has_express = TRUE
GROUP by city_name;

SELECT *
FROM orders
JOIN customers USING(customer_id)
JOIN cities USING(city_id)
where TIMESTAMPDIFF(
    MINUTE,order_datetime,delivered_datetime) > 60
GROUP by city_name


