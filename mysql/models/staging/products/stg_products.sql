

with raw_products as (
 select * from {{ref('raw_products')}}
)


/** select products when color is not null and transform stock_quantity different to null values**/

select product_id, CONCAT(UCASE(LEFT(product_name,1)), LCASE(SUBSTRING(product_name, 2))) as product_name, CONCAT(UCASE(LEFT(category, 1)), 
LCASE(SUBSTRING(category, 2))) as category, ROUND(price, 2) as price, 
CASE WHEN description IS NOT NULL THEN description WHEN description IS NULL THEN '-' END as description,
 CASE WHEN color IS NOT NULL THEN CONCAT(UCASE(LEFT(color, 1)), LCASE(SUBSTRING(color, 2))) WHEN COLOR IS NULL THEN '-' END as color,  CASE 
WHEN stock_quantity >=1 THEN stock_quantity 
WHEN stock_quantity<1 THEN  0 
WHEN stock_quantity IS NULL THEN 0  
END  as stock_quantity, CAST(last_updated as DATE) as last_updated from raw_products
