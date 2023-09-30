with o as (
select 
orderid, 
to_date(orderdate,'yyyy/mm/dd') as orderdate, 
to_date(shipdate,'yyyy/mm/dd') as shipdate, 
shipmode, 
customerid, 
productid, 
ordercostprice, 
ordersellingprice, 
(ordersellingprice - ordercostprice) as orderprofit
from 
{{ ref('src_orders') }}
), 
c as 
(select customerid, customername, segment, country from {{ ref('src_customers') }}),
p as
(select productid, category, subcategory, productname from {{ ref('src_products') }} )
select o.orderid, o.orderdate, o.shipdate, o.shipmode, c.customerid, c.customername, c.segment, c.country, p.productid, p.category, p.subcategory, p.productname,o.ordercostprice,o.ordersellingprice, o.orderprofit
from 
o left join c on o.customerid = c.customerid 
  left join p on o.productid = p.productid