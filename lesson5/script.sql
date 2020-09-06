-- 1. ����� � ������� users ���� created_at � updated_at ��������� ��������������.
-- ��������� �� �������� ����� � ��������.

UPDATE users SET created_at = now(), updated_at = now();


-- 2. ������� users ���� �������� ��������������.
-- ������ created_at � updated_at ���� ������ ����� VARCHAR � � ��� ������ ����� ���������� �������� � ������� 20.10.2017 8:10.
-- ���������� ������������� ���� � ���� DATETIME, �������� �������� ����� ��������.
UPDATE users SET
  created_at = STR_TO_DATE(created_at, '%d.%m.%Y %k:%i'),
  updated_at = STR_TO_DATE(updated_at, '%d.%m.%Y %k:%i');

ALTER TABLE
  users
CHANGE
  created_at created_at DATETIME DEFAULT CURRENT_TIMESTAMP;

ALTER TABLE
  users
CHANGE
  updated_at updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP;

-- 3. � ������� ��������� ������� storehouses_products � ���� value ����� ����������� ����� ������ �����:
-- 0, ���� ����� ���������� � ���� ����, ���� �� ������ ������� ������.
-- ���������� ������������� ������ ����� �������, ����� ��� ���������� � ������� ���������� �������� value.
-- ������ ������� ������ ������ ���������� � �����, ����� ���� �������.
SELECT *
FROM
  storehouses_products
ORDER BY
  IF(value > 0, 0, 1),
  value;


-- 4. �� ������� users ���������� ������� �������������, ���������� � ������� � ���.
-- ������ ������ � ���� ������ ���������� �������� (may, august)
SELECT name FROM users WHERE DATE_FORMAT(birthday_at, '%M') IN ('may', 'august');


-- 5. �� ������� catalogs ����������� ������ ��� ������ �������.
-- SELECT * FROM catalogs WHERE id IN (5, 1, 2);
-- ������������ ������ � �������, �������� � ������ in
SELECT *
FROM catalogs
WHERE id IN (5, 1, 2)
ORDER BY FIELD(id, 5, 1, 2);




-- 1. ����������� ������� ������� ������������� � ������� users.
SELECT AVG(TIMESTAMPDIFF(YEAR, birthday_at, NOW())) AS age FROM users;


-- 2. ����������� ���������� ���� ��������, ������� ���������� �� ������ �� ���� ������. ������� ������, ��� ���������� ��� ������ �������� ����, � �� ���� ��������.


-- 3. (�� �������) ����������� ������������ ����� � ������� �������.


