CREATE TABLE IF NOT EXISTS `authors` (
    author_id INT auto_increment PRIMARY KEY,
    author_name VARCHAR(50) NOT NULL
);

CREATE TABLE IF NOT EXISTS `genres` (
    genre_id INT auto_increment PRIMARY KEY,
    genre_name VARCHAR(50) NOT NULL
);

CREATE TABLE IF NOT EXISTS `books` (
    book_id INT auto_increment PRIMARY KEY,
    title VARCHAR(150) NOT NULL,
    publication_year YEAR,
    author_id INT,
    genre_id INT,
    FOREIGN KEY (author_id) REFERENCES authors(author_id),
    FOREIGN KEY (genre_id) REFERENCES genres(genre_id)
);


CREATE TABLE IF NOT EXISTS `users` (
    user_id INT auto_increment PRIMARY KEY,
    username VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL
);


CREATE TABLE IF NOT EXISTS `borrowed_books` (
    borrow_id INT auto_increment PRIMARY KEY,
    book_id INT,
    user_id INT,
    borrow_date DATE NOT NULL,
    return_date DATE,
    FOREIGN KEY (book_id) REFERENCES books(book_id),
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);



-- 1. Додаємо авторів
INSERT INTO authors (author_name) VALUES ('Taras Shevchenko'), ('George Orwell');

-- 2. Додаємо жанри
INSERT INTO genres (genre_name) VALUES ('Poetry'), ('Dystopian');

-- 3. Додаємо книги (тут ми використовуємо ID авторів та жанрів, які створили вище)
INSERT INTO books (title, publication_year, author_id, genre_id) 
VALUES ('Kobzar', 1840, 1, 1), ('1984', 1949, 2, 2);

-- 4. Додаємо користувачів
INSERT INTO users (username, email) 
VALUES ('oleksii_user', 'oleksii@example.com'), ('ivan_reader', 'ivan@test.ua');

-- 5. Додаємо запис у журнал (хтось взяв книгу)
INSERT INTO borrowed_books (book_id, user_id, borrow_date, return_date) 
VALUES (1, 1, '2024-05-01', '2024-05-15'), (2, 2, '2024-05-10', NULL);


SELECT * FROM authors;
SELECT * FROM genres;
SELECT * FROM users;


USE LibraryManagement;
-- Видаляємо дані, щоб почати з чистого листа
DELETE FROM borrowed_books;
DELETE FROM books;
DELETE FROM authors;
DELETE FROM genres;
DELETE FROM users;


SET FOREIGN_KEY_CHECKS = 0; -- Тимчасово вимикаємо перевірку зв'язків

TRUNCATE TABLE LibraryManagement.borrowed_books;
TRUNCATE TABLE LibraryManagement.books;
TRUNCATE TABLE LibraryManagement.authors;
TRUNCATE TABLE LibraryManagement.genres;
TRUNCATE TABLE LibraryManagement.users;

SET FOREIGN_KEY_CHECKS = 1; -- Вмикаємо перевірку назад

DELETE FROM borrowed_books;




-- 2.1. Додаємо авторів
INSERT INTO authors (author_name) VALUES 
('Джон Р. Р. Толкін'),
('Джоан Роулінг'),
('Джордж Р. Р. Мартін');

-- 2.2. Додаємо жанри
INSERT INTO genres (genre_name) VALUES 
('Фентезі'),
('Наукова фантастика'),
('Детектив');

-- 2.3. Додаємо користувачів
INSERT INTO users (username, email) VALUES 
('oleksii_booklover', 'oleksii@example.com'),
('anna_reader', 'anna@example.com'),
('max_fantastic', 'max@example.com');

-- 2.4. Додаємо книги (використовуємо реальні author_id та genre_id)
INSERT INTO books (title, publication_year, author_id, genre_id) VALUES 
('Володар перснів', 1954, 1, 1),          -- Толкін, фентезі (genre_id 1)
('Гаррі Поттер і філософський камінь', 1997, 2, 1),  -- Роулінг, фентезі
('Гра престолів', 1996, 3, 1),             -- Мартін, фентезі
('1984', 1949, NULL, 2);                   -- Без автора, наукова фантастика

-- 2.5. Додаємо записи про взяті книги
INSERT INTO borrowed_books (book_id, user_id, borrow_date, return_date) VALUES 
(1, 1, '2025-12-01', '2026-01-01'),   -- Толкін взяв Олексій
(2, 2, '2026-01-10', NULL),            -- Гаррі Поттер взяла Анна (не повернула)
(3, 3, '2025-11-15', '2025-12-15');    -- Гра престолів взяв Макс

SELECT * FROM authors;
SELECT * FROM books;
SELECT * FROM borrowed_books;
SELECT * FROM users;


SHOW TABLES;

USE goit_hw3;


SELECT *
FROM order_details AS od
INNER JOIN orders AS o ON od.order_id = o.id
INNER JOIN products AS pr ON od.product_id = pr.id
INNER JOIN customers AS cs ON o.customer_id = cs.id
INNER JOIN categories AS ct ON pr.category_id = ct.id
INNER JOIN employees AS em ON o.employee_id = em.id
INNER JOIN shippers AS sh ON o.shipper_id = sh.id
INNER JOIN suppliers AS su ON pr.supplier_id = su.id
LIMIT 20;


SELECT *
FROM order_details AS od
INNER JOIN orders AS o ON od.order_id = o.order_id
INNER JOIN products AS pr ON od.product_id = pr.product_id
INNER JOIN customers AS cs ON o.customer_id = cs.customer_id
INNER JOIN categories AS ct ON pr.category_id = ct.category_id
INNER JOIN employees AS em ON o.employee_id = em.employee_id
INNER JOIN shippers AS sh ON o.shipper_id = sh.shipper_id
INNER JOIN suppliers AS su ON pr.supplier_id = su.supplier_id
LIMIT 20;

SELECT * FROM order_details;
SELECT * FROM orders;
SELECT * FROM products;
SELECT * FROM customers;
SELECT * FROM categories;
SELECT * FROM employees;
SELECT * FROM shippers;
SELECT * FROM suppliers;


SELECT 
    od.id AS order_detail_id,
    o.id AS order_id,
    o.date AS order_date,
    cs.name AS customer_name,
    pr.name AS product_name,
    ct.name AS category_name,
    em.last_name AS employee_last_name,
    sh.name AS shipper_name,
    su.name AS supplier_name,
    od.quantity,
    od.unit_price
FROM order_details AS od
INNER JOIN orders AS o          ON od.order_id = o.id
INNER JOIN customers AS cs      ON o.customer_id = cs.id
INNER JOIN products AS pr       ON od.product_id = pr.id
INNER JOIN categories AS ct     ON pr.category_id = ct.id
INNER JOIN employees AS em      ON o.employee_id = em.employee_id
INNER JOIN shippers AS sh       ON o.shipper_id = sh.id
INNER JOIN suppliers AS su      ON pr.supplier_id = su.id
LIMIT 20;



SELECT *
FROM order_details AS od
INNER JOIN orders AS o ON od.order_id = o.order_id
INNER JOIN products AS pr ON od.product_id = pr.id
INNER JOIN customers AS cs ON o.customer_id = cs.id
INNER JOIN categories AS ct ON pr.category_id = ct.id
INNER JOIN employees AS em ON o.employee_id = em.employee_id
INNER JOIN shippers AS sh ON o.shipper_id = sh.id
INNER JOIN suppliers AS su ON pr.supplier_id = su.id
LIMIT 20;

SELECT *
FROM order_details AS od
INNER JOIN orders AS o ON od.order_id = o.order_id
INNER JOIN products AS pr ON od.product_id = pr.id
INNER JOIN customers AS cs ON o.customer_id = cs.id
INNER JOIN categories AS ct ON pr.category_id = ct.id
INNER JOIN employees AS em ON o.employee_id = em.employee_id
INNER JOIN shippers AS sh ON o.shipper_id = sh.id
INNER JOIN suppliers AS su ON pr.supplier_id = su.id
LIMIT 20;




-- 4.1. Кількість рядків повного INNER JOIN
SELECT COUNT(*) AS total_rows
FROM order_details AS od
INNER JOIN orders AS o ON od.order_id = o.id
INNER JOIN products AS pr ON od.product_id = pr.id
INNER JOIN customers AS cs ON o.customer_id = cs.id
INNER JOIN categories AS ct ON pr.category_id = ct.id
INNER JOIN employees AS em ON o.employee_id = em.employee_id
INNER JOIN shippers AS sh ON o.shipper_id = sh.id
INNER JOIN suppliers AS su ON pr.supplier_id = su.id;



-- 4.2. LEFT JOIN (всі INNER замінені на LEFT)
SELECT COUNT(*) AS total_left
FROM order_details AS od
LEFT JOIN orders AS o ON od.order_id = o.id
LEFT JOIN products AS pr ON od.product_id = pr.id
LEFT JOIN customers AS cs ON o.customer_id = cs.id
LEFT JOIN categories AS ct ON pr.category_id = ct.id
LEFT JOIN employees AS em ON o.employee_id = em.employee_id
LEFT JOIN shippers AS sh ON o.shipper_id = sh.id
LEFT JOIN suppliers AS su ON pr.supplier_id = su.id;


-- 4.3. Фільтр employee_id > 3 і <= 10
SELECT *
FROM order_details AS od
INNER JOIN orders AS o ON od.order_id = o.id
INNER JOIN products AS pr ON od.product_id = pr.id
INNER JOIN customers AS cs ON o.customer_id = cs.id
INNER JOIN categories AS ct ON pr.category_id = ct.id
INNER JOIN employees AS em ON o.employee_id = em.employee_id
INNER JOIN shippers AS sh ON o.shipper_id = sh.id
INNER JOIN suppliers AS su ON pr.supplier_id = su.id
WHERE em.employee_id > 3 AND em.employee_id <= 10
LIMIT 20;


-- 4.4. Групування за назвою категорії + COUNT + AVG(quantity)
SELECT 
    ct.name AS category_name,
    COUNT(*) AS total_rows,
    AVG(od.quantity) AS avg_quantity
FROM order_details AS od
INNER JOIN orders AS o ON od.order_id = o.id
INNER JOIN products AS pr ON od.product_id = pr.id
INNER JOIN categories AS ct ON pr.category_id = ct.id
INNER JOIN customers AS cs ON o.customer_id = cs.id
INNER JOIN employees AS em ON o.employee_id = em.employee_id
INNER JOIN shippers AS sh ON o.shipper_id = sh.id
INNER JOIN suppliers AS su ON pr.supplier_id = su.id
GROUP BY ct.name;


-- 4.5. Фільтр HAVING avg_quantity > 21
SELECT 
    ct.name AS category_name,
    COUNT(*) AS total_rows,
    AVG(od.quantity) AS avg_quantity
FROM order_details AS od
INNER JOIN orders AS o ON od.order_id = o.id
INNER JOIN products AS pr ON od.product_id = pr.id
INNER JOIN categories AS ct ON pr.category_id = ct.id
INNER JOIN customers AS cs ON o.customer_id = cs.id
INNER JOIN employees AS em ON o.employee_id = em.employee_id
INNER JOIN shippers AS sh ON o.shipper_id = sh.id
INNER JOIN suppliers AS su ON pr.supplier_id = su.id
GROUP BY ct.name
HAVING AVG(od.quantity) > 21;





-- 4.6. Сортування за спаданням кількості рядків
SELECT 
    ct.name AS category_name,
    COUNT(*) AS total_rows,
    AVG(od.quantity) AS avg_quantity
FROM order_details AS od
INNER JOIN orders AS o ON od.order_id = o.id
INNER JOIN products AS pr ON od.product_id = pr.id
INNER JOIN categories AS ct ON pr.category_id = ct.id
INNER JOIN customers AS cs ON o.customer_id = cs.id
INNER JOIN employees AS em ON o.employee_id = em.employee_id
INNER JOIN shippers AS sh ON o.shipper_id = sh.id
INNER JOIN suppliers AS su ON pr.supplier_id = su.id
GROUP BY ct.name
HAVING AVG(od.quantity) > 21
ORDER BY total_rows DESC;





-- 4.7. Вивести 4 рядки, пропустивши перший
SELECT 
    ct.name AS category_name,
    COUNT(*) AS total_rows,
    AVG(od.quantity) AS avg_quantity
FROM order_details AS od
INNER JOIN orders AS o ON od.order_id = o.id
INNER JOIN products AS pr ON od.product_id = pr.id
INNER JOIN categories AS ct ON pr.category_id = ct.id
INNER JOIN customers AS cs ON o.customer_id = cs.id
INNER JOIN employees AS em ON o.employee_id = em.employee_id
INNER JOIN shippers AS sh ON o.shipper_id = sh.id
INNER JOIN suppliers AS su ON pr.supplier_id = su.id
GROUP BY ct.name
HAVING AVG(od.quantity) > 21
ORDER BY total_rows DESC
LIMIT 4 OFFSET 1;



-- 4.7. Вивести 4 рядки з пропущеним першим
SELECT 
    ct.name AS category_name,
    COUNT(*) AS total_rows,
    AVG(od.quantity) AS avg_quantity
FROM order_details AS od
INNER JOIN orders AS o ON od.order_id = o.id
INNER JOIN products AS pr ON od.product_id = pr.id
INNER JOIN categories AS ct ON pr.category_id = ct.id
INNER JOIN customers AS cs ON o.customer_id = cs.id
INNER JOIN employees AS em ON o.employee_id = em.employee_id
INNER JOIN shippers AS sh ON o.shipper_id = sh.id
INNER JOIN suppliers AS su ON pr.supplier_id = su.id
GROUP BY ct.name
HAVING AVG(od.quantity) > 21
ORDER BY total_rows DESC
LIMIT 4 OFFSET 1;


-- 4.6. Сортування за спаданням кількості рядків
SELECT 
    ct.name AS category_name,
    COUNT(*) AS total_rows,
    AVG(od.quantity) AS avg_quantity
FROM order_details AS od
INNER JOIN orders AS o ON od.order_id = o.id
INNER JOIN products AS pr ON od.product_id = pr.id
INNER JOIN categories AS ct ON pr.category_id = ct.id
INNER JOIN customers AS cs ON o.customer_id = cs.id
INNER JOIN employees AS em ON o.employee_id = em.employee_id
INNER JOIN shippers AS sh ON o.shipper_id = sh.id
INNER JOIN suppliers AS su ON pr.supplier_id = su.id
GROUP BY ct.name
HAVING AVG(od.quantity) > 21
ORDER BY total_rows DESC;


-- 4.7. Вивести 4 рядки, пропустивши перший (OFFSET 1 LIMIT 4)
SELECT 
    ct.name AS category_name,
    COUNT(*) AS total_rows,
    AVG(od.quantity) AS avg_quantity
FROM order_details AS od
INNER JOIN orders AS o ON od.order_id = o.id
INNER JOIN products AS pr ON od.product_id = pr.id
INNER JOIN categories AS ct ON pr.category_id = ct.id
INNER JOIN customers AS cs ON o.customer_id = cs.id
INNER JOIN employees AS em ON o.employee_id = em.employee_id
INNER JOIN shippers AS sh ON o.shipper_id = sh.id
INNER JOIN suppliers AS su ON pr.supplier_id = su.id
GROUP BY ct.name
HAVING AVG(od.quantity) > 21
ORDER BY total_rows DESC
LIMIT 4 OFFSET 1;