-- =================================
-- 3. Определить кто больше поставил лайков (всего) - мужчины или женщины?
select P.gender, count(P.gender)
from likes L
  inner join profiles P on P.user_id = L.user_id
group by P.gender
order by count(P.gender) desc
limit 1;


-- =================================
-- 4. Подсчитать общее количество лайков десяти самым молодым пользователям (сколько лайков получили 10 самых молодых пользователей).
select P.user_id, count(P.user_id)
from likes L
  inner join profiles P on P.user_id = L.target_id and L.target_type_id = 2
group by P.user_id
order by P.birthday desc, count(P.user_id) desc
limit 10;


-- =================================
-- 5. Найти 10 пользователей, которые проявляют наименьшую активность в использовании социальной сети
-- За критерий активности возьму дату последнего сообщения
select U.*
from messages M
  inner join users U on U.id = M.from_user_id
order by M.created_at asc
limit 10;