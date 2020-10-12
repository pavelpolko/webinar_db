-- Хранимые процедуры / триггеры;

DROP TRIGGER IF EXISTS products_properties_validation;
DELIMITER //

CREATE TRIGGER products_properties_validation BEFORE INSERT ON products_properties

FOR EACH ROW BEGIN
  IF !is_row_exists(NEW.product_id, NEW.property_id) THEN
    SIGNAL SQLSTATE "45000"
    SET MESSAGE_TEXT = "Такаякомбинация товара и свойства уже существует";
  END IF;
END//

DELIMITER ;