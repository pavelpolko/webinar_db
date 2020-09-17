-- 1. В базе данных shop и sample присутствуют одни и те же таблицы, учебной базы данных.
--    Переместите запись id = 1 из таблицы shop.users в таблицу sample.users. Используйте транзакции.
START TRANSACTION;
  INSERT INTO sample.users SELECT * FROM shop.users WHERE id = 1;
  DELETE FROM shop.users WHERE id = 1;
COMMIT;

-- 2. Создайте представление, которое выводит название name товарной позиции из таблицы products
--    и соответствующее название каталога name из таблицы catalogs.
CREATE OR REPLACE VIEW products_catalogs AS
SELECT
  P.name AS product,
  C.name AS catalog
FROM products P
  INNER JOIN catalogs C ON P.catalog_id = C.id;
 
-- 3. Пусть имеется таблица с календарным полем created_at.
--    В ней размещены разряженые календарные записи за август 2018 года '2018-08-01', '2016-08-04', '2018-08-16' и 2018-08-17.
--    Составьте запрос, который выводит полный список дат за август, выставляя в соседнем поле значение 1, если дата присутствует в исходном таблице и 0, если она отсутствует.
DROP TABLE IF EXISTS tables;
CREATE TABLE IF NOT EXISTS tables (
  id SERIAL PRIMARY KEY,
  created_at DATE NOT NULL
);

INSERT INTO tables VALUES
(1,'2018-08-01'),
(2,'2018-08-04'),
(3,'2018-08-16'),
(4,'2018-08-17');

DROP TABLE IF EXISTS table_days;
CREATE TEMPORARY TABLE table_days (
  day INT
);

INSERT INTO table_days VALUES
(0), (1), (2), (3), (4), (5), (6), (7), (8), (9), (10),
(11), (12), (13), (14), (15), (16), (17), (18), (19), (20),
(21), (22), (23), (24), (25), (26), (27), (28), (29), (30);

SELECT
  DATE(DATE('2018-08-31') - INTERVAL D.day DAY) AS day,
  NOT ISNULL(T.id) AS order_exist
FROM table_days AS D
  LEFT JOIN tables AS T ON DATE(DATE('2018-08-31') - INTERVAL D.day DAY) = T.created_at
ORDER BY day;
 
-- 4. Пусть имеется любая таблица с календарным полем created_at.
--    Создайте запрос, который удаляет устаревшие записи из таблицы, оставляя только 5 самых свежих записей.
DROP TABLE IF EXISTS tables;
CREATE TABLE IF NOT EXISTS tables (
  id SERIAL PRIMARY KEY,
  created_at DATE NOT NULL
);

INSERT INTO tables VALUES
(1, '2018-08-01'),
(2, '2018-08-02'),
(3, '2018-08-03'),
(4, '2018-08-04'),
(5, '2018-08-05'),
(6, '2018-08-06'),
(7, '2018-08-07'),
(8, '2018-08-08'),
(9, '2018-08-09'),
(10, '2018-08-10');

DELETE tables
FROM tables
  INNER JOIN
  (
    SELECT created_at
    FROM tables
    ORDER BY created_at DESC
    LIMIT 5, 1
  ) AS table2
ON
  tables.created_at <= table2.created_at;

SELECT * FROM tables;
