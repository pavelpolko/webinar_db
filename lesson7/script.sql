-- 1. Составьте список пользователей users, которые осуществили хотя бы один заказ orders в интернет магазине.
select U.*
from users U
  inner join orders O on O.user_id  = U.id;
 
 
-- 2. Выведите список товаров products и разделов catalogs, который соответствует товару.
select P.name, C.name
from products P
  inner join catalogs C on C.id = P.catalog_id;
 
 
-- 3. Пусть имеется таблица рейсов flights (id, from, to) и таблица городов cities (label, name).
--    Поля from, to и label содержат английские названия городов, поле name — русское.
--    Выведите список рейсов flights с русскими названиями городов.
select F.id, C1.name as 'from', C2.name as 'to'
from flights F
  inner join cities C1 on C1.`label` = F.`from`
  inner join cities C2 on C2.`label` = F.`to`
  
  