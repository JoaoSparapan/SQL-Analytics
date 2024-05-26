with customer_group as (
select  
	c.company_name
	, sum((od.unit_price * od.quantity) * (1-od.discount)) as total
	, NTILE(5) OVER (ORDER BY sum((od.unit_price * od.quantity) * (1-od.discount))) AS group_num
from orders o
join customers c ON c.customer_id = o.customer_id
join order_details od ON od.order_id = o.order_id
group by 1
order by 2 desc
)

select
	*
from customer_group
where group_num > 2