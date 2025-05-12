/* Creating view in DB (w.o modifying sales raw data) **/
select * from {{source('dbt-demo', 'sales')}}