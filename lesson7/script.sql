-- 1. ��������� ������ ������������� users, ������� ����������� ���� �� ���� ����� orders � �������� ��������.
select U.*
from users U
  inner join orders O on O.user_id  = U.id;
 
 
-- 2. �������� ������ ������� products � �������� catalogs, ������� ������������� ������.
select P.name, C.name
from products P
  inner join catalogs C on C.id = P.catalog_id;
 
 
-- 3. ����� ������� ������� ������ flights (id, from, to) � ������� ������� cities (label, name).
--    ���� from, to � label �������� ���������� �������� �������, ���� name � �������.
--    �������� ������ ������ flights � �������� ���������� �������.
select F.id, C1.name as 'from', C2.name as 'to'
from flights F
  inner join cities C1 on C1.`label` = F.`from`
  inner join cities C2 on C2.`label` = F.`to`
  
  