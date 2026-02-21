with all_orders AS (
select 
OrderID,
CustomerID,
ProductID,
OrderDate,
Quantity,
Revenue,
COGS
from Orders_2023

union all

select 
OrderID,
CustomerID,
ProductID,
OrderDate,
Quantity,
Revenue,
COGS
from Orders_2024

union all


select 
OrderID,
CustomerID,
ProductID,
OrderDate,
Quantity,
Revenue,
COGS
from Orders_2025)



---building the main dataset query

select

a.OrderID,
c.Region,
a.CustomerID,
a.productID,
a.OrderDate,
DATEADD(week, DATEDIFF(week,0, a.OrderDate),0) as Week_Date,
c.CustomerJoinDate,
a.Quantity,
a.Revenue,
CASE WHEN a.Revenue is null then p.Price * a.Quantity else a.Revenue end as cleaned_revenue,
a.Revenue - a.COGS as profit,
a.COGS,
p.productname,
p.productcategory,
p.price,
p.base_cost

from all_orders a
left join customers c
on a.CustomerID = c.CustomerID
left join products p
on a.productID = p.ProductID
where a.CustomerID is not null --dropping the non customer 