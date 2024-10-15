CREATE TABLE products (
    id SERIAL PRIMARY KEY,
    product_name VARCHAR(100),
    price DECIMAL(10, 2),
    stock_quantity INTEGER
);

CREATE TABLE customers (
    id SERIAL PRIMARY KEY,
    first_name VARCHAR(100),
    last_name VARCHAR(100),
    email VARCHAR(100)
);

CREATE TABLE orders (
    id SERIAL PRIMARY KEY,
    customer_id INTEGER,
    order_date DATE,
    FOREIGN KEY (customer_id) REFERENCES customers(id)
);

CREATE TABLE order_items (
    order_id INTEGER,
    product_id INTEGER,
    quantity INTEGER,
    PRIMARY KEY (order_id, product_id),
    FOREIGN KEY (order_id) REFERENCES orders(id),
    FOREIGN KEY (product_id) REFERENCES products(id)
);

INSERT INTO products (product_name, price, stock_quantity)
VALUES 
('Booster Pack', 5.00, 100),
('Starter Deck', 20.00, 50),
('Collectors Box', 100.00, 30),
('Playmat', 25.00, 40),
('Card Sleeves (100 pack)', 10.00, 200);

INSERT INTO customers (first_name, last_name, email)
VALUES 
('Mike', 'Paul', 'bigmike@example.com'),
('Adan', 'Sparkes', 'adsparkes@example.com'),
('Charles', 'Johnson', 'charlesjohnson99@example.com'),
('Antonio', 'Davis', 'biglaker@example.com');

INSERT INTO orders (customer_id, order_date)
VALUES 
(1, '2024-10-10'),
(2, '2024-10-11'),
(3, '2024-10-12'),
(4, '2024-10-13'),
(1, '2024-10-14');

INSERT INTO order_items (order_id, product_id, quantity)
VALUES

(1, 1, 5), 
(1, 3, 1), 
(2, 2, 1), 
(2, 4, 1), 
(3, 1, 10),
(3, 5, 1), 
(4, 3, 1), 
(4, 4, 1), 
(5, 2, 1),
(5, 5, 2); 


SELECT product_name, stock_quantity
FROM products;

SELECT products.product_name, order_items.quantity
FROM order_items
JOIN products ON order_items.product_id = products.id
WHERE order_items.order_id = 1;

SELECT orders.id , order_items.product_id, order_items.quantity
FROM orders
JOIN order_items ON orders.id = order_items.order_id
WHERE orders.customer_id = 2

-- The order I am simulating the update for is order 1, which contains 5 booster packs and 1 collectors box, this update with reduce the amount in stock by the amount order
-- by subtracting the order items quantity from the stock quantity and directly updating stock quantity with that number.
UPDATE products
SET stock_quantity = stock_quantity - order_items.quantity
FROM order_items 
WHERE products.id = order_items.product_id
AND order_items.order_id = 1;

DELETE FROM orders
WHERE id = 2
DELETE FROM order_items
WHERE order_id = 2;
