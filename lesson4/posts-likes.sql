-- Реализация лайков и постов

-- Посты делает пользователь
-- Посты могут быть в группе (сообщество), личный пост (на своей странице)
CREATE TABLE `posts` (
  id int(10) unsigned NOT NULL AUTO_INCREMENT PRIMARY key COMMENT 'Идентификатор',
  user_id int(10) unsigned NOT NULL COMMENT 'ID пользователя',
  post_type_id INT UNSIGNED NOT NULL COMMENT 'ID типа поста',
  community_id INT UNSIGNED NOT NULL COMMENT 'ID сообщества, куда написан пост',
  message text COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Текст сообщения',
  created_at datetime DEFAULT current_timestamp() COMMENT 'Дата создания поста',
  updated_at datetime DEFAULT current_timestamp() ON UPDATE current_timestamp() COMMENT 'Дата изменения поста',
) COMMENT 'Посты пользователя';

-- Связь постов и медиа файлов
CREATE TABLE `media_posts` (
  post_id INT UNSIGNED NOT NULL COMMENT COMMENT 'ID поста',
  media_id INT UNSIGNED NOT NULL COMMENT 'ID файла',
  created_at datetime DEFAULT current_timestamp() COMMENT 'Дата добавления медиа файла',
  PRIMARY KEY (post_id, media_id) COMMENT 'Ключ по двум полям'
) COMMENT 'Связь постов и медиа файлов';

-- Типы постов
CREATE TABLE post_types (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT 'Идентификатор строки',
  name VARCHAR(255) NOT NULL UNIQUE COMMENT 'Название типа',
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT 'Дата добавления',
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Дата изменения'
) COMMENT 'Типы постов';

-- Связь постов и пользователей, просмотревших этот пост
CREATE TABLE `view_post_users` (
  post_id INT UNSIGNED NOT NULL COMMENT COMMENT 'ID поста',
  user_id INT UNSIGNED NOT NULL COMMENT 'ID пользователя',
  created_at datetime DEFAULT current_timestamp() COMMENT 'Дата добавления',
  PRIMARY KEY (post_id, user_id) COMMENT 'Ключ по двум полям'
) COMMENT 'Связь постов и пользователей, просмотревших этот пост';



-- Лайки ставит пользователь
-- Лайкать можно посты, фотографии, комментарии к посту, комментарии к фото
-- Для объекта лайка можно сделать поле JSON, в котором будет информация о том, какому типу объекта поставлен лайк
-- Например:
-- metadata = {"post_id":"12345"} - лайк поставлен для поста
-- metadata = {"message_id":"12345"} - лайк поставлен для комментария
-- metadata = {"media_id":"12345"} - лайк поставлен для фотографии
CREATE TABLE `likes` (
  id int(10) unsigned NOT NULL AUTO_INCREMENT PRIMARY key COMMENT 'Идентификатор',
  user_id int(10) unsigned NOT NULL COMMENT 'ID пользователя',
  metadata JSON COMMENT 'Информация об объекте, куда поставлен лайк',
  created_at datetime DEFAULT current_timestamp() COMMENT 'Дата добавления',
) COMMENT 'Посты пользователя';
