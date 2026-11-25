/* ============================================================================
   QUESTION (Q4: National spike or regional?)
   Stakeholder: Sneha Iyer (Category Manager, Fever & Cold)
   Task: Compare 'Fever & Cold' sales in Sep–Oct 2026 vs. Sep–Oct 2025 
         by region, including the Year-over-Year (YoY) growth percentage.
   ============================================================================
   APPROACH:
   1. Join & Filter (CTE 1 - filtered_sales): 
      Connect orders, order_items, products, customers, and cities. Filter 
      early for 'Delivered' orders, 'Fulfilled' items, the 'Fever & Cold' 
      category, and orders placed in September or October of 2025 and 2026.
   2. Conditional Aggregation (CTE 2 - regional_sales): 
      Group by region and use CASE inside SUM() to pivot 2025 and 2026 
      revenue into side-by-side columns.
   3. YoY Growth Calculation (Final SELECT): 
      Compute ((2026 Sales - 2025 Sales) / 2025 Sales) * 100, using NULLIF 
      to prevent division-by-zero errors, and sort by highest 2026 sales.
   ============================================================================ */

USE tata1mg_db;

WITH filtered_sales AS (
    SELECT 
        c.region,
        YEAR(o.order_datetime) AS order_year,
        (oi.quantity * oi.unit_price) AS item_sales
    FROM orders o
    JOIN order_items oi USING (order_id)
    JOIN products p     USING (product_id)
    JOIN customers cust USING (customer_id)
    JOIN cities c       USING (city_id)
    WHERE o.order_status = 'Delivered'
      AND oi.item_status = 'Fulfilled'
      AND p.category = 'Fever & Cold'
      AND YEAR(o.order_datetime) IN (2025, 2026)
      AND MONTH(o.order_datetime) IN (9, 10)
),
regional_sales AS (
    SELECT 
        region,
        ROUND(SUM(CASE WHEN order_year = 2025 THEN item_sales ELSE 0 END), 2) AS sales_sep_oct_2025,
        ROUND(SUM(CASE WHEN order_year = 2026 THEN item_sales ELSE 0 END), 2) AS sales_sep_oct_2026
    FROM filtered_sales
    GROUP BY region
)
SELECT 
    region,
    sales_sep_oct_2025,
    sales_sep_oct_2026,
    ROUND(
        ((sales_sep_oct_2026 - sales_sep_oct_2025) / NULLIF(sales_sep_oct_2025, 0)) * 100, 
        2
    ) AS yoy_growth_pct
FROM regional_sales
ORDER BY sales_sep_oct_2026 DESC;
