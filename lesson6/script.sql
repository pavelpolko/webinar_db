-- Добавляем внешние ключи в БД vk
-- Для таблицы профилей

-- Смотрим структуру таблицы
DESC profiles;

-- Добавляем внешние ключи
ALTER TABLE profiles
  ADD CONSTRAINT profiles_user_id_fk 
    FOREIGN KEY (user_id) REFERENCES users(id)
      ON DELETE CASCADE,
  ADD CONSTRAINT profiles_photo_id_fk
    FOREIGN KEY (photo_id) REFERENCES media(id)
      ON DELETE SET NULL;

-- Изменяем тип столбца при необходимости
ALTER TABLE profiles DROP FOREIGN KEY profiles_user_id_fk;
ALTER TABLE profiles MODIFY COLUMN photo_id INT(10) UNSIGNED;
      
-- Для таблицы сообщений

-- Смотрим структур в таблицы
DESC messages;

-- Добавляем внешние ключи
ALTER TABLE messages
  ADD CONSTRAINT messages_from_user_id_fk 
    FOREIGN KEY (from_user_id) REFERENCES users(id),
  ADD CONSTRAINT messages_to_user_id_fk 
    FOREIGN KEY (to_user_id) REFERENCES users(id);

-- Смотрим диаграмму отношений в DBeaver (ERDiagram)


-- Если нужно удалить
ALTER TABLE table_name DROP FOREIGN KEY constraint_name;

-- Добавил посты с помощью http://filldb.info
desc posts;

-- Проверим корректность даты создания и даты обновления
select * from posts where created_at > updated_at ;

-- Уменьшим дату создания на 800 дней
update posts set created_at = created_at - INTERVAL 800 DAY where created_at > updated_at;

-- =================================
-- 2. Создать все необходимые внешние ключи и диаграмму отношений.
-- ПРОДОЛЖАЮ добавлять внешние ключи

-- Добавляем внешние ключи для media
ALTER TABLE media
  ADD CONSTRAINT media_media_type_id_fk
    FOREIGN KEY (media_type_id) REFERENCES media_types(id),
  ADD CONSTRAINT media_user_id_fk
    FOREIGN KEY (user_id) REFERENCES users(id);
   
-- Добавляем внешние ключи для communities_users
ALTER TABLE communities_users 
  ADD CONSTRAINT communities_users_community_id_fk
    FOREIGN KEY (community_id) REFERENCES communities(id),
  ADD CONSTRAINT communities_users_user_id_fk
    FOREIGN KEY (user_id) REFERENCES users(id);

-- Добавляем внешние ключи для friendship
ALTER TABLE friendship
  ADD CONSTRAINT friendship_user_id_fk
    FOREIGN KEY (user_id) REFERENCES users(id),
  ADD CONSTRAINT friendship_friend_id_fk
    FOREIGN KEY (friend_id) REFERENCES users(id),
  ADD CONSTRAINT friendship_status_id_fk
    FOREIGN KEY (status_id) REFERENCES friendship_statuses(id);
   
-- Добавляем внешние ключи для likes
ALTER TABLE likes
  ADD CONSTRAINT likes_user_id_fk
    FOREIGN KEY (user_id) REFERENCES users(id),
  ADD CONSTRAINT likes_target_type_id_fk
    FOREIGN KEY (target_type_id) REFERENCES target_types(id);

   
-- Добавляем внешние ключи для posts
ALTER TABLE posts
  ADD CONSTRAINT posts_user_id_fk
    FOREIGN KEY (user_id) REFERENCES users(id),
  ADD CONSTRAINT posts_community_id_fk
    FOREIGN KEY (community_id) REFERENCES communities(id),
  ADD CONSTRAINT posts_media_id_fk
    FOREIGN KEY (media_id) REFERENCES media(id);

   
-- =================================
-- 3. Определить кто больше поставил лайков (всего) - мужчины или женщины?
select P.gender, count(P.gender)
from likes L
  inner join profiles P on P.user_id = L.user_id
group by P.gender
order by count(P.gender) desc
limit 1;


-- =================================
-- 4. Подсчитать общее количество лайков десяти самым молодым пользователям (сколько лайков получили 10 самых молодых пользователей)
select P.user_id, count(P.user_id)
from likes L
  inner join profiles P on P.user_id = L.user_id
group by P.user_id
order by P.birthday desc, count(P.user_id) desc
limit 10;


-- =================================
-- 5. Найти 10 пользователей, которые проявляют наименьшую активность в использовании социальной сети
-- Критерий активной возьму по датам сообщений, написанным в таблице messages
select distinct from_user_id
from messages
order by created_at asc
limit 10;


 
 
