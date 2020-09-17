-- 2. В таблице products есть два текстовых поля: name с названием товара и description с его описанием.
--    Допустимо присутствие обоих полей или одно из них.
--    Ситуация, когда оба поля принимают неопределенное значение NULL неприемлема.
--    Используя триггеры, добейтесь того, чтобы одно из этих полей или оба поля были заполнены.
--    При попытке присвоить полям NULL-значение необходимо отменить операцию.

DELIMITER //

DROP TRIGGER IF exists validate_name_description_insert //
CREATE TRIGGER validate_name_description_insert BEFORE INSERT ON products
FOR EACH ROW BEGIN
  IF NEW.name IS NULL AND NEW.description IS NULL THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'Необходимо заполнить хотя бы одно из полей NAME или DESCRIPTION';
  END IF;
END//

DROP TRIGGER IF exists validate_name_description_update //
CREATE TRIGGER validate_name_description_update BEFORE UPDATE ON products
FOR EACH ROW BEGIN
  IF NEW.name IS NULL AND NEW.description IS NULL THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'Необходимо заполнить хотя бы одно из полей NAME или DESCRIPTION';
  END IF;
END//

-- Проверяем
DELIMITER ;

INSERT INTO products (name, description)
VALUES (NULL, NULL);

INSERT INTO products (name, description)
VALUES ('Apple', 'Apple description');

INSERT INTO products (name, description)
VALUES (NULL, 'Samsung description');

INSERT INTO products (name, description)
VALUES ('Samsung', NULL);
