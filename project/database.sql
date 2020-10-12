-- Скрипты создания структуры БД (с первичными ключами, индексами, внешними ключами);

CREATE DATABASE IF NOT EXISTS historyprice;
USE historyprice;

-- users - Пользователи
-- products - Товары
-- prices - Цены
-- categories - Категории товаров
-- shops - Магазины
-- subscibers - Подписчики
-- wishlists - Список слежения
-- actions - Список заданий для импорта XML
-- properties - Свойства (характеристики) товаров
-- products_properties - Значения свойств товаров

-- Пользователи
CREATE TABLE IF NOT EXISTS users (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Идентификатор строки",
  name VARCHAR(255) NOT NULL COMMENT "Имя пользователя",
  email VARCHAR(100) NOT NULL UNIQUE COMMENT "Почта",
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки",  
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления строки"
) COMMENT "Пользователи";

-- Товары
CREATE TABLE IF NOT EXISTS products (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Идентификатор строки", 
  article VARCHAR(255) NOT NULL COMMENT "Артикул товара",
  name VARCHAR(255) NOT NULL COMMENT "Название товара",
  description TEXT NOT NULL COMMENT "Описание товара",
  shop_id INT UNSIGNED NOT NULL COMMENT "Ссылка на магазин",
  url VARCHAR(255) NOT NULL COMMENT "Адрес товара",
  category_id INT UNSIGNED NOT NULL COMMENT "Ссылка на категорию",
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки",  
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления строки"
) COMMENT "Товары";

-- Цены
CREATE TABLE IF NOT EXISTS prices (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Идентификатор строки", 
  price DECIMAL(18,2) NOT NULL COMMENT "Цена товара",
  price_date DATETIME NOT NULL COMMENT "Дата цены товара",
  product_id INT UNSIGNED NOT NULL COMMENT "Ссылка на товар",
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки",  
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления строки"
) COMMENT "Цены";

-- Категории товаров
CREATE TABLE IF NOT EXISTS categories (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Идентификатор строки", 
  name VARCHAR(255) NOT NULL COMMENT "Название категории",
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки",  
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления строки"
) COMMENT "Категории товаров";

-- Магазины
CREATE TABLE IF NOT EXISTS shops (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Идентификатор строки", 
  name VARCHAR(255) NOT NULL COMMENT "Название магазина",
  url VARCHAR(255) NOT NULL COMMENT "Адрес магазина",
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки",  
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления строки"
) COMMENT "Магазины";

-- Подписчики
CREATE TABLE IF NOT EXISTS subscibers (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Идентификатор строки",
  user_id INT UNSIGNED NULL COMMENT "Ссылка на пользователя, если он существует по совпадению email",
  email VARCHAR(100) NOT NULL UNIQUE COMMENT "Почта",
  is_actived BOOLEAN COMMENT "Признак активной подписки",
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки",  
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления строки"
) COMMENT "Подписчики";

-- Список слежения
CREATE TABLE IF NOT EXISTS wishlists (
  user_id INT UNSIGNED NOT NULL COMMENT "Ссылка на пользователя",
  product_id INT UNSIGNED NOT NULL COMMENT "Ссылка на товар",
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки",  
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления строки",
  PRIMARY KEY (user_id, product_id) COMMENT "Составной первичный ключ"
) COMMENT "Список слежения";

-- Свойства (характеристики) товаров
CREATE TABLE IF NOT EXISTS properties (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Идентификатор строки", 
  name VARCHAR(255) NOT NULL COMMENT "Название свойства",
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки",  
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления строки"
) COMMENT "Свойства (характеристики) товаров";

-- Значения свойств товаров
CREATE TABLE IF NOT EXISTS products_properties (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Идентификатор строки", 
  product_id INT UNSIGNED NOT NULL COMMENT "Ссылка на товар",
  property_id INT UNSIGNED NOT NULL COMMENT "Ссылка на свойство",
  value VARCHAR(255) NOT NULL COMMENT "Значение свойства",
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки",  
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления строки"
) COMMENT "Значения свойств товаров";



-- Добавляем внешние ключи

-- ALTER TABLE products DROP FOREIGN KEY products_shop_id_fk;
-- ALTER TABLE products DROP FOREIGN KEY products_category_id_fk;
ALTER TABLE products
  ADD CONSTRAINT products_shop_id_fk 
    FOREIGN KEY (shop_id) REFERENCES shops(id),
  ADD CONSTRAINT products_category_id_fk 
    FOREIGN KEY (category_id) REFERENCES categories(id);

-- ALTER TABLE prices DROP FOREIGN KEY prices_product_id_fk;
ALTER TABLE prices
  ADD CONSTRAINT prices_product_id_fk 
    FOREIGN KEY (product_id) REFERENCES products(id);

-- ALTER TABLE wishlists DROP FOREIGN KEY wishlists_user_id_id_fk;
-- ALTER TABLE wishlists DROP FOREIGN KEY wishlists_product_id_fk;
ALTER TABLE wishlists
  ADD CONSTRAINT wishlists_user_id_id_fk 
    FOREIGN KEY (user_id) REFERENCES users(id),
  ADD CONSTRAINT wishlists_product_id_fk 
    FOREIGN KEY (product_id) REFERENCES products(id);

-- ALTER TABLE subscibers DROP FOREIGN KEY subscibers_user_id_fk;
ALTER TABLE subscibers
  ADD CONSTRAINT subscibers_user_id_fk 
    FOREIGN KEY (user_id) REFERENCES users(id);

-- ALTER TABLE products_properties DROP FOREIGN KEY products_properties_property_id_id_fk;
-- ALTER TABLE products_properties DROP FOREIGN KEY products_properties_product_id_fk;
ALTER TABLE products_properties
  ADD CONSTRAINT products_properties_property_id_id_fk 
    FOREIGN KEY (property_id) REFERENCES properties(id),
  ADD CONSTRAINT products_properties_product_id_fk 
    FOREIGN KEY (product_id) REFERENCES products(id);
   
   
-- Добавляем индексы
DROP INDEX prices_product_id_idx ON prices;
CREATE INDEX prices_product_id_idx ON prices(product_id);

DROP INDEX products_category_id_idx ON products;
CREATE INDEX products_category_id_idx ON products(category_id);

DROP INDEX products_shop_id_idx ON products;
CREATE INDEX products_shop_id_idx ON products(shop_id);

DROP INDEX products_properties_product_id_idx ON products_properties;
CREATE INDEX products_properties_product_id_idx ON products_properties(product_id);

DROP INDEX products_properties_property_id_idx ON products_properties;
CREATE INDEX products_properties_property_id_idx ON products_properties(property_id);
