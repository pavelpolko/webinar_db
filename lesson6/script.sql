-- ��������� ������� ����� � �� vk
-- ��� ������� ��������

-- ������� ��������� �������
DESC profiles;

-- ��������� ������� �����
ALTER TABLE profiles
  ADD CONSTRAINT profiles_user_id_fk 
    FOREIGN KEY (user_id) REFERENCES users(id)
      ON DELETE CASCADE,
  ADD CONSTRAINT profiles_photo_id_fk
    FOREIGN KEY (photo_id) REFERENCES media(id)
      ON DELETE SET NULL;

-- �������� ��� ������� ��� �������������
ALTER TABLE profiles DROP FOREIGN KEY profiles_user_id_fk;
ALTER TABLE profiles MODIFY COLUMN photo_id INT(10) UNSIGNED;
      
-- ��� ������� ���������

-- ������� �������� � �������
DESC messages;

-- ��������� ������� �����
ALTER TABLE messages
  ADD CONSTRAINT messages_from_user_id_fk 
    FOREIGN KEY (from_user_id) REFERENCES users(id),
  ADD CONSTRAINT messages_to_user_id_fk 
    FOREIGN KEY (to_user_id) REFERENCES users(id);

-- ������� ��������� ��������� � DBeaver (ERDiagram)


-- ���� ����� �������
ALTER TABLE table_name DROP FOREIGN KEY constraint_name;

-- ������� ����� � ������� http://filldb.info
desc posts;

-- �������� ������������ ���� �������� � ���� ����������
select * from posts where created_at > updated_at ;

-- �������� ���� �������� �� 800 ����
update posts set created_at = created_at - INTERVAL 800 DAY where created_at > updated_at;

-- =================================
-- 2. ������� ��� ����������� ������� ����� � ��������� ���������.
-- ��������� ��������� ������� �����

-- ��������� ������� ����� ��� media
ALTER TABLE media
  ADD CONSTRAINT media_media_type_id_fk
    FOREIGN KEY (media_type_id) REFERENCES media_types(id),
  ADD CONSTRAINT media_user_id_fk
    FOREIGN KEY (user_id) REFERENCES users(id);
   
-- ��������� ������� ����� ��� communities_users
ALTER TABLE communities_users 
  ADD CONSTRAINT communities_users_community_id_fk
    FOREIGN KEY (community_id) REFERENCES communities(id),
  ADD CONSTRAINT communities_users_user_id_fk
    FOREIGN KEY (user_id) REFERENCES users(id);

-- ��������� ������� ����� ��� friendship
ALTER TABLE friendship
  ADD CONSTRAINT friendship_user_id_fk
    FOREIGN KEY (user_id) REFERENCES users(id),
  ADD CONSTRAINT friendship_friend_id_fk
    FOREIGN KEY (friend_id) REFERENCES users(id),
  ADD CONSTRAINT friendship_status_id_fk
    FOREIGN KEY (status_id) REFERENCES friendship_statuses(id);
   
-- ��������� ������� ����� ��� likes
ALTER TABLE likes
  ADD CONSTRAINT likes_user_id_fk
    FOREIGN KEY (user_id) REFERENCES users(id),
  ADD CONSTRAINT likes_target_type_id_fk
    FOREIGN KEY (target_type_id) REFERENCES target_types(id);

   
-- ��������� ������� ����� ��� posts
ALTER TABLE posts
  ADD CONSTRAINT posts_user_id_fk
    FOREIGN KEY (user_id) REFERENCES users(id),
  ADD CONSTRAINT posts_community_id_fk
    FOREIGN KEY (community_id) REFERENCES communities(id),
  ADD CONSTRAINT posts_media_id_fk
    FOREIGN KEY (media_id) REFERENCES media(id);

   
-- =================================
-- 3. ���������� ��� ������ �������� ������ (�����) - ������� ��� �������?
select P.gender, count(P.gender)
from likes L
  inner join profiles P on P.user_id = L.user_id
group by P.gender
order by count(P.gender) desc
limit 1;


-- =================================
-- 4. ���������� ����� ���������� ������ ������ ����� ������� ������������� (������� ������ �������� 10 ����� ������� �������������)
select P.user_id, count(P.user_id)
from likes L
  inner join profiles P on P.user_id = L.user_id
group by P.user_id
order by P.birthday desc, count(P.user_id) desc
limit 10;


-- =================================
-- 5. ����� 10 �������������, ������� ��������� ���������� ���������� � ������������� ���������� ����
-- �������� �������� ������ �� ����� ���������, ���������� � ������� messages
select distinct from_user_id
from messages
order by created_at asc
limit 10;


 
 
