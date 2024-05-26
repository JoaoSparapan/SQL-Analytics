with clients_by_uk as (
select
	c.company_name
	, SUM(od.unit_price * od.quantity * (1.0 - od.discount) * 100) / 100 AS payments
from customers c
join orders o on o.customer_id = c.customer_id
join order_details od on od.order_id = o.order_id
where upper(c.country) = 'UK'
group by 1
)

select * from clients_by_uk where payments>1000