
WITH sales as (
 SELECT * FROM {{ref('raw_sales')}}
)


SELECT DISTINCT sale_id, customer_id, product_id, CASE WHEN quantity IS NOT NULL THEN quantity WHEN quantity IS NULL OR quantity<0 THEN 0 END as quantity, CAST(sale_date  as DATE) as sale_date, ROUND(total_amount, 2) as total_amount from sales