
drop table IF exists ordersitem;
drop table IF exists orders;
drop table IF exists products;

CREATE TABLE products (
id int(11) NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT 'уникальное значение',
name varchar(10) NOT NULL COMMENT 'Название товаров'
) COMMENT = 'Товары';

CREATE TABLE orders (
id int(11) NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT 'уникальное значение',
date_orders date COMMENT 'Дата заказа',
name varchar(10) NOT NULL COMMENT 'Комментарий'
) COMMENT = 'Заказы';

CREATE TABLE ordersitem (
id int(11) NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT 'уникальное значение',
id_orders int(11) NOT NULL COMMENT 'ссылка на Заказы',
id_products int(11) NOT NULL COMMENT 'ссылка на Товары', 
qty int(10) NOT NULL COMMENT 'Кол-во товара в заказе' 
) COMMENT = 'Позиции заказов';

ALTER TABLE ordersitem ADD CONSTRAINT ordersitem_fk1 
						   FOREIGN KEY (id_products) REFERENCES products(id);
ALTER TABLE ordersitem ADD CONSTRAINT ordersitem_fk2 
						   FOREIGN KEY (id_orders) REFERENCES orders(id);

INSERT INTO products(name)
VALUES 
('Хлеб'),
('Машина'),
('Квартира'),
('Колбаса');

INSERT INTO orders(date_orders, name)
VALUES 
(str_to_date('01.04.2021', '%d.%m.%Y'), 'Какой-то камментарий');

INSERT INTO ordersitem(id_orders, id_products, qty)
VALUES 
(1, 1, 2),
(1, 2, 2),
(1, 3, 1),
(1, 4, 3);

COMMIT;

SELECT p.name, COUNT(oi.id), oi.qty 
FROM products p, orders o, ordersitem oi
WHERE p.id = oi.id_products 
  AND oi.id_orders = o.id
GROUP BY p.name, oi.qty ;

