with raw_customers_view as (
 select * from {{ ref('raw_customers')}}
)



select distinct customer_id, first_name, last_name, city, CASE WHEN state IS NOT NULL THEN state WHEN state IS NULL THEN '-' END as state, country from raw_customers_view