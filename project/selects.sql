-- Скрипты характерных выборок (включающие группировки, JOIN'ы, вложенные таблицы);

-- Кол-во товаров, сгруппированные по категориям
select c.name as category_name, count(p.id) as count_products
from products p
  left join categories c on c.id = p.category_id
group by c.id;

-- Кол-во товаров, сгруппированные по магазинам
select s.name as shop_name, count(p.id) as count_products
from products p
  left join shops s on s.id = p.shop_id 
group by s.id;

-- Все цены товара
select p.id, p.name, p2.price, p2.price_date
from products p
  left join prices p2 on p2.product_id = p.id
order by p.id, p2.price_date desc;

-- Все свойства товара
select p.id, p.name, p2.name as property_name, pp.value as property_value
from products p
  left join products_properties pp on pp.product_id = p.id
  left join properties p2 on p2.id = pp.property_id
order by p.id, p2.name;

-- Список товаров пользователей для слежения
select u.name as user_name, p.name as product_name
from wishlists w
  left join users u on u.id = w.user_id 
  left join products p on p.id = w.product_id;

-- Товары, за которыми следят больше всего
select p.name as product_name, count(w.product_id) as count_products
from wishlists w
  left join users u on u.id = w.user_id 
  left join products p on p.id = w.product_id
group by p.name
order by count_products desc;