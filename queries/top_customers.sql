select  
	c.company_name
	, sum((od.unit_price * od.quantity) * (1-od.discount)) as total
from orders o
join customers c ON c.customer_id = o.customer_id
join order_details od ON od.order_id = o.order_id
group by 1
order by 2 desc