with receitas_mensais as (
	select
		extract(year from o.order_date) as ano
		, extract(month from o.order_date) as mes
		, sum((od.unit_price * od.quantity) * (1-od.discount)) as total
	from orders o
	inner join order_details od on o.order_id = od.order_id
	group by 1,2
	order by 1,2
),

receitas_mensais_YTD as (
	select
		ano
		, mes
		, total
		, sum(total) over (PARTITION by ano order by mes) as receita_YTD
	from receitas_mensais
)

SELECT 
	ano
	, mes
	, total
	, total - lag(total) over (partition by ano order by mes) as diferenca_mensal
	, receita_YTD
	, (total - lag(total) over (partition by ano order by mes)) / lag(total) over (partition by ano order by mes) * 100 as diferenca_mensal_YTD
FROM receitas_mensais_YTD