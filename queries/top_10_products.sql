select
	p.product_id
	, p.product_name
	, SUM(od.unit_price * od.quantity * (1.0 - od.discount)) AS total_sales
from order_details od
join products p ON p.product_id = od.product_id
group by 1
order by 3 desc
limit 10