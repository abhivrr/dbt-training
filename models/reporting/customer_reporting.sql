select 
    customerid,
    customername,
    country,
    segment,
    sum(orderprofit) as productprofit
 from {{ ref('stage_orders') }}
group by 
    customerid,
    customername,
    country,
    segment