-- Database and table creation
CREATE DATABASE inventory_sales_db;
USE inventory_sales_db;

CREATE TABLE stock (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    quantity INT NOT NULL,
    price DECIMAL(10,2) NOT NULL
);

CREATE TABLE sales (
    id INT AUTO_INCREMENT PRIMARY KEY,
    item_id INT NOT NULL,
    quantity INT NOT NULL,
    sale_date DATE NOT NULL DEFAULT CURDATE(),
    total_price DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (item_id) REFERENCES stock(id)
);
