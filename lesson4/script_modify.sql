-- ѕроверил профили, которые младше 2005 года (меньше 15 лет)
select * from profiles where birthday > '2005-01-01';

-- ѕроверил дату рождени€ пользователей и отнимал 800 дней от даты рождени€ у тех профилей, которые младше 2005 года
-- «апрос выполн€л несколько раз, пока не осталось таких профилей
update profiles set birthday = birthday - INTERVAL 800 DAY where birthday > '2005-01-01';

-- ѕроверил есть ли сообщени€, которые написаны самому себе
select * from messages where from_user_id = to_user_id ;

-- ѕроверил есть ли запросы на дружбу, которые посланы самому себе
select * from friendship where user_id = friend_id ;

-- ѕроверим, есть ли элементы, дл€ которых дата создани€ больше, чем дата обновлени€
select * from communities where created_at > updated_at ;

-- ќтнимаем 360 дней из даты создани€ и выполн€ем запрос до тех пор, пока дата создани€ не станет меньше даты обновлени€
update communities set created_at = created_at - INTERVAL 360 DAY where created_at > updated_at;