select 
	sum((od.unit_price * od.quantity) * (1-od.discount)) as total 
from order_details od
join (
	select order_id from orders where EXTRACT(year from orders.order_date) = 1997
) as o
on o.order_id = od.order_id