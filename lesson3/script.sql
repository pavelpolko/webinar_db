-- �������� �� ��� ���������� ���� ���������
-- https://vk.com/geekbrainsru

-- ������ ��
CREATE DATABASE vk;

-- ������ � �������
USE vk;

-- ������ ������� �������������
CREATE TABLE users (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "������������� ������", 
  first_name VARCHAR(100) NOT NULL COMMENT "��� ������������",
  last_name VARCHAR(100) NOT NULL COMMENT "������� ������������",
  email VARCHAR(100) NOT NULL UNIQUE COMMENT "�����",
  phone VARCHAR(100) NOT NULL UNIQUE COMMENT "�������",
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "����� �������� ������",  
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "����� ���������� ������"
) COMMENT "������������";  

-- ������� ��������
CREATE TABLE profiles (
  user_id INT UNSIGNED NOT NULL PRIMARY KEY COMMENT "������ �� ������������", 
  gender CHAR(1) NOT NULL COMMENT "���",
  birthday DATE COMMENT "���� ��������",
  photo_id INT UNSIGNED COMMENT "������ �� �������� ���������� ������������",
  city_id INT UNSIGNED NOT NULL COMMENT "����� ����������",
  country_id INT UNSIGNED NOT NULL COMMENT "������ ����������",
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "����� �������� ������",  
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "����� ���������� ������"
) COMMENT "�������"; 

-- ������� �������
CREATE TABLE cities (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "������������� ������",
  name VARCHAR(150) NOT NULL UNIQUE COMMENT "�������� ������",
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "����� �������� ������",  
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "����� ���������� ������"  
) COMMENT "������";

-- ������� �����
CREATE TABLE countries (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "������������� ������",
  name VARCHAR(150) NOT NULL UNIQUE COMMENT "�������� ������",
  code_letter VARCHAR(3) NOT NULL UNIQUE COMMENT "��������� ���",
  code_numeric INT NOT NULL COMMENT "�������� ���",
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "����� �������� ������",  
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "����� ���������� ������"  
) COMMENT "������";

-- ������� ���������
CREATE TABLE messages (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "������������� ������", 
  from_user_id INT UNSIGNED NOT NULL COMMENT "������ �� ����������� ���������",
  to_user_id INT UNSIGNED NOT NULL COMMENT "������ �� ���������� ���������",
  answer_id INT COMMENT "������ �� ���������, ����� �� ������ ���������",
  body TEXT NOT NULL COMMENT "����� ���������",
  is_important BOOLEAN COMMENT "������� ��������",
  is_delivered BOOLEAN COMMENT "������� ��������",
  is_viewed BOOLEAN COMMENT "������� ���������",
  delivered_at DATETIME COMMENT "����� ��������",
  viewed_at DATETIME COMMENT "����� ���������",
  created_at DATETIME DEFAULT NOW() COMMENT "����� �������� ������",
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "����� ���������� ������"
) COMMENT "���������";

-- ������� ����� ��������� � �����������
CREATE TABLE messages_media (
  message_id INT UNSIGNED NOT NULL COMMENT "������ �� ���������",
  media_id INT UNSIGNED NOT NULL COMMENT "������ �� ���������",
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "����� �������� ������", 
  PRIMARY KEY (message_id, media_id) COMMENT "��������� ��������� ����"
) COMMENT "���������� � ��������� ������������, ����� ����� ����������� � ������������";

-- ������� ������
CREATE TABLE friendship (
  user_id INT UNSIGNED NOT NULL COMMENT "������ �� ���������� ��������� ���������",
  friend_id INT UNSIGNED NOT NULL COMMENT "������ �� ���������� ����������� �������",
  status_id INT UNSIGNED NOT NULL COMMENT "������ �� ������ (������� ���������) ���������",
  requested_at DATETIME DEFAULT NOW() COMMENT "����� ����������� ����������� �������",
  confirmed_at DATETIME COMMENT "����� ������������� �����������",
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "����� �������� ������",  
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "����� ���������� ������",  
  PRIMARY KEY (user_id, friend_id) COMMENT "��������� ��������� ����"
) COMMENT "������� ������";

-- ������� �������� ��������� ���������
CREATE TABLE friendship_statuses (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "������������� ������",
  name VARCHAR(150) NOT NULL UNIQUE COMMENT "�������� �������",
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "����� �������� ������",  
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "����� ���������� ������"  
) COMMENT "������� ������";

-- ������� �����
CREATE TABLE communities (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "������������� ������",
  name VARCHAR(150) NOT NULL UNIQUE COMMENT "�������� ������",
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "����� �������� ������",  
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "����� ���������� ������"  
) COMMENT "������";

-- ������� ����� ������������� � �����
CREATE TABLE communities_users (
  community_id INT UNSIGNED NOT NULL COMMENT "������ �� ������",
  user_id INT UNSIGNED NOT NULL COMMENT "������ �� ������������",
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "����� �������� ������", 
  PRIMARY KEY (community_id, user_id) COMMENT "��������� ��������� ����"
) COMMENT "��������� �����, ����� ����� �������������� � ��������";

-- ������� �����������
CREATE TABLE media (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "������������� ������",
  user_id INT UNSIGNED NOT NULL COMMENT "������ �� ������������, ������� �������� ����",
  filename VARCHAR(255) NOT NULL COMMENT "���� � �����",
  size INT NOT NULL COMMENT "������ �����",
  metadata JSON COMMENT "���������� �����",
  media_type_id INT UNSIGNED NOT NULL COMMENT "������ �� ��� ��������",
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "����� �������� ������",
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "����� ���������� ������"
) COMMENT "����������";

-- ������� ����� �����������
CREATE TABLE media_types (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "������������� ������",
  name VARCHAR(255) NOT NULL UNIQUE COMMENT "�������� ����",
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "����� �������� ������",  
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "����� ���������� ������"
) COMMENT "���� �����������";


-- ������������� ����� ��������� ���� SQL
-- https://www.sqlstyle.guide/ru/

-- ��������� ������� � ������ ��������� 
-- �� http://filldb.info

-- ������������
-- https://dev.mysql.com/doc/refman/8.0/en/
-- http://www.rldp.ru/mysql/mysql80/index.htm


 
