DROP FUNCTION IF EXISTS is_row_exists;
DELIMITER //

CREATE FUNCTION is_row_exists (product_id INT, property_id INT)
RETURNS BOOLEAN READS SQL DATA

BEGIN
  DECLARE value VARCHAR(50);
  SELECT pp.value FROM products_properties pp WHERE pp.product_id = product_id and pp.property_id = property_id limit 1 into value;
  
  CASE length(value)
    WHEN 0 THEN
      RETURN FALSE;
    ELSE 
      RETURN TRUE;
  END CASE;
  
END//

DELIMITER ;

SELECT is_row_exists(88, 1);