/* ============================================================================
   CHAPTER 3: FLU SEASON REVIEW | WEEK 2 • MONDAY, 11:00 AM
   QUESTION 4: National spike or regional?
   ============================================================================

   STAKEHOLDER CONTEXT:
   - Sneha Iyer (Category Manager, Fever & Cold):
     "Paracetamol and ORS flew off the shelves this season. Was that all of
      India, or one region?"

   YOUR TASK:
   - Compare Fever & Cold sales in Sep–Oct 2026 with Sep–Oct 2025, by region,
     with YoY growth %.

   HINT:
   - Count only fulfilled items on delivered orders.

   AVAILABLE TABLES:
   - orders
   - order_items
   - products
   - customers
   - cities

   SUGGESTED SQL SKILLS:
   - CASE inside SUM
   - CTE
   - YEAR() / MONTH()
   ============================================================================ */

-- Write your SQL query below:

-- USE database
USE tata1mg_db;

-- check respective tables (orders, order_items, products, customers, cities)
-- SELECT * FROM orders, order_items, products, customers, cities;

WITH sales_data AS (SELECT region, quantity*unit_price AS sales, order_datetime
FROM orders
JOIN order_items USING(order_id)
JOIN products USING(product_id)
JOIN customers USING(customer_id)
JOIN cities USING(city_id)
WHERE order_status = 'Delivered' AND item_status = 'Fulfilled' AND category = 'Fever & Cold'),

cte_sales25 AS (SELECT region, SUM(sales) AS sale25
FROM sales_data
WHERE order_datetime >= '2025-09-01' AND order_datetime <= '2025-10-31'
GROUP BY region),

cte_sales26 AS (SELECT region, SUM(sales) AS sale26
FROM sales_data
WHERE order_datetime >= '2026-09-01' AND order_datetime <= '2026-10-31'
GROUP BY region)

-- SELECT region, sales25, sales26, ROUND((sale26-sales25/sales25)*100,2) AS YOY_growth
-- FROM cte_sales25
-- JOIN cte_sales26 USING(region)

SELECT *, ROUND(((sale26 - sale25)/sale25)*100,2) AS YOY_growth
FROM cte_sales25
JOIN cte_sales26 USING(region)
order by YOY_growth desc











