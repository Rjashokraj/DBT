with bronze_sales as (
    select 
       sales_id,
       product_sk,
       customer_sk,
       {{multiply('quantity', 'unit_price')}} as calculated_gross_amount,
       gross_amount,
       payment_method
    from
        {{ref('bronze_sales')}}
),
bronze_products as(
    select
       product_sk,
       category
    from
       {{ref('bronze_product')}} 
),
bronze_customer as(
    select
       customer_sk,
       gender
    from
        {{ref('bronze_customer')}}
),
joined_query as (
select 
    bronze_sales.sales_id,
    bronze_sales.gross_amount,
    bronze_sales.payment_method,
    bronze_products.category,
    bronze_customer.gender
from
   bronze_sales
join
    bronze_products on bronze_sales.product_sk = bronze_products.product_sk
join
    bronze_customer on bronze_sales.customer_sk = bronze_customer.customer_sk
)

select 
    category,
    gender,
    sum(gross_amount) as total_sales
from
    joined_query
group by
    category,gender
order by
    total_sales desc