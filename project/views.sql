-- Представления (минимум 2);

create or replace view v_products_prices as
select p.id, p.name, p2.price, p2.price_date
from products p
  left join prices p2 on p2.product_id = p.id
order by p.id, p2.price_date desc;

select * from v_products_prices;


create or replace view v_products_properties as
select p.id, p.name, p2.name as property_name, pp.value as property_value
from products p
  left join products_properties pp on pp.product_id = p.id
  left join properties p2 on p2.id = pp.property_id
order by p.id, p2.name;

select * from v_products_properties;
