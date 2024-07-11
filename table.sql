CREATE DATABASE StoreFront;
USE StoreFront;

# user table 
CREATE TABLE users(
id INT PRIMARY KEY AUTO_INCREMENT,
name VARCHAR(50) NOT NULL,
username VARCHAR(50) NOT NULL,
password VARCHAR(50) NOT NULL,
usertype ENUM("Adminstrator", "Shopper") NOT NULL,
mobile_no BIGINT NOT NULL
);

# address table
CREATE TABLE address(
id INT PRIMARY KEY AUTO_INCREMENT,
user_id INT,
address VARCHAR(255) NOT NULL,
city VARCHAR(50) NOT NULL,
state VARCHAR(50) NOT NULL,
zipcode int NOT NULL,
FOREIGN KEY (user_id) REFERENCES users(id)
);

# product table
CREATE TABLE product(
id INT PRIMARY KEY AUTO_INCREMENT,
name VARCHAR(50) NOT NULL,
description TEXT,
price DECIMAL(10,2) NOT NULL,
quantity INT NOT NULL,
image_urls JSON
);

# category table
CREATE TABLE category(
id INT PRIMARY KEY AUTO_INCREMENT,
name varchar(50),
parent_id INT,
FOREIGN KEY (parent_id) REFERENCES category(id) ON UPDATE CASCADE ON DELETE CASCADE 
);

#Product category relationship table
CREATE TABLE product_category_relation(
category_id INT,
product_id INT,
FOREIGN KEY(category_id) REFERENCES category(id) ON UPDATE CASCADE ON DELETE CASCADE,
FOREIGN KEY(product_id) REFERENCES product(id) ON UPDATE CASCADE ON DELETE CASCADE
);

# order table
CREATE TABLE orders(
id INT PRIMARY KEY AUTO_INCREMENT,
user_id INT,
address_id INT,
order_date DATE NOT NULL,
total_amount DECIMAL(10,2) NOT NULL,
FOREIGN KEY (user_id) REFERENCES users(id) ON UPDATE CASCADE ON DELETE CASCADE ,
FOREIGN KEY (address_id) REFERENCES address(id) ON UPDATE CASCADE ON DELETE CASCADE 
);

# item table
CREATE TABLE items(
id INT PRIMARY KEY AUTO_INCREMENT,
order_id INT NOT NULL,
product_id INT NOT NULL,
quantity INT NOT NULL,
price DECIMAL(10, 2),
status ENUM("Placed","Shipped","Cancelled","Returned") NOT NULL,
FOREIGN KEY (order_id) REFERENCES orders(id) ON UPDATE CASCADE ON DELETE CASCADE ,
FOREIGN KEY (product_id) REFERENCES product(id) ON UPDATE CASCADE ON DELETE CASCADE 
);


# displaying all the table names present in StoreFront.
SHOW TABLES;

SET FOREIGN_KEY_CHECKS = 0;
DROP TABLE product;

CREATE TABLE product(
id INT PRIMARY KEY AUTO_INCREMENT,
name VARCHAR(50) NOT NULL,
description TEXT,
price DECIMAL(10,2) NOT NULL,
quantity INT NOT NULL,
image_urls JSON
);

