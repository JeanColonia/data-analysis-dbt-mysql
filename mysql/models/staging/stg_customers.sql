with raw_customers_view as (
 select * from {{ ref('raw_customers')}}
)



select distinct customer_id, first_name, last_name, city, state, country from raw_customers_view  where state IS NOT NULL