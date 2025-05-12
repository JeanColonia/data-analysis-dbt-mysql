/* Creating view in DB (w.o modifying product raw data) **/
select * from {{source('dbt-demo', 'products')}}