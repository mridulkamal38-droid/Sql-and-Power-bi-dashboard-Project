create view supplier_report as 
select 
s.coffeeshop_id,
s.supplier_name,
s.coffee_type,
ss.coffeeshop_name,
ss.city_id,
l.city,
l.country
from dbo.suppliers as s
left join dbo.shops as ss
on s.coffeeshop_id = ss.coffeeshop_id
left join dbo.locations as l
on ss.city_id = l.city_id