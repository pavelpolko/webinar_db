-- ���������� ������ � ������

-- ����� ������ ������������
-- ����� ����� ���� � ������ (����������), ������ ���� (�� ����� ��������)
CREATE TABLE `posts` (
  id int(10) unsigned NOT NULL AUTO_INCREMENT PRIMARY key COMMENT '�������������',
  user_id int(10) unsigned NOT NULL COMMENT 'ID ������������',
  post_type_id INT UNSIGNED NOT NULL COMMENT 'ID ���� �����',
  community_id INT UNSIGNED NOT NULL COMMENT 'ID ����������, ���� ������� ����',
  message text COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '����� ���������',
  created_at datetime DEFAULT current_timestamp() COMMENT '���� �������� �����',
  updated_at datetime DEFAULT current_timestamp() ON UPDATE current_timestamp() COMMENT '���� ��������� �����',
) COMMENT '����� ������������';

-- ����� ������ � ����� ������
CREATE TABLE `media_posts` (
  post_id INT UNSIGNED NOT NULL COMMENT COMMENT 'ID �����',
  media_id INT UNSIGNED NOT NULL COMMENT 'ID �����',
  created_at datetime DEFAULT current_timestamp() COMMENT '���� ���������� ����� �����',
  PRIMARY KEY (post_id, media_id) COMMENT '���� �� ���� �����'
) COMMENT '����� ������ � ����� ������';

-- ���� ������
CREATE TABLE post_types (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT '������������� ������',
  name VARCHAR(255) NOT NULL UNIQUE COMMENT '�������� ����',
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '���� ����������',
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '���� ���������'
) COMMENT '���� ������';

-- ����� ������ � �������������, ������������� ���� ����
CREATE TABLE `view_post_users` (
  post_id INT UNSIGNED NOT NULL COMMENT COMMENT 'ID �����',
  user_id INT UNSIGNED NOT NULL COMMENT 'ID ������������',
  created_at datetime DEFAULT current_timestamp() COMMENT '���� ����������',
  PRIMARY KEY (post_id, user_id) COMMENT '���� �� ���� �����'
) COMMENT '����� ������ � �������������, ������������� ���� ����';



-- ����� ������ ������������
-- ������� ����� �����, ����������, ����������� � �����, ����������� � ����
-- ��� ������� ����� ����� ������� ���� JSON, � ������� ����� ���������� � ���, ������ ���� ������� ��������� ����
-- ��������:
-- metadata = {"post_id":"12345"} - ���� ��������� ��� �����
-- metadata = {"message_id":"12345"} - ���� ��������� ��� �����������
-- metadata = {"media_id":"12345"} - ���� ��������� ��� ����������
CREATE TABLE `likes` (
  id int(10) unsigned NOT NULL AUTO_INCREMENT PRIMARY key COMMENT '�������������',
  user_id int(10) unsigned NOT NULL COMMENT 'ID ������������',
  metadata JSON COMMENT '���������� �� �������, ���� ��������� ����',
  created_at datetime DEFAULT current_timestamp() COMMENT '���� ����������',
) COMMENT '����� ������������';
