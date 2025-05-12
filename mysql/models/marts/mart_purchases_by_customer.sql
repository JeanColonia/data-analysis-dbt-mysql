SELECT 
c.customer_id,
CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
COUNT(s.sale_id) AS total_purchases,
SUM(s.quantity) AS total_quantity,
ROUND(SUM(s.total_amount),2 ) AS total_spent,
c.country
FROM {{ref('stg_customers')}} AS c
INNER JOIN {{ref('stg_sales')}} AS s ON c.customer_id = s.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name, c.country