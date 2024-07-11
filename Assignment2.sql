USE StoreFront;

INSERT INTO category(id, name, parent_id)
VALUES
(1, 'electronic appliances', NULL),
(2, 'home and furniture', NULL),
(3, 'tv and appliances', NULL),
(4, 'fashion', NULL),
(5, 'mobile', 1),
(6, 'mobile accessories', 1),
(7, 'laptop', 1),
(8, 'home decor', 2);

INSERT INTO product(name, description, price, quantity, image_urls)
VALUES
('Mobile', 'Samsung Smartphone', 30000, 14, '["https://img.etimg.com/photo/msid-98945112,imgsize-13860/SamsungGalaxyS23Ultra.jpg"]'),
('Mobile', 'Redmi Smartphone', 20000, 16, '["https://img.etimg.com/thumb/width-1200,height-900,imgsize-15226,resizemode-75,msid-105996652/top-trending-products/mobile-phones/redmi-note-11-discover-key-features-price-pros-and-cons-of-this-xiaomi-smartphone.jpg"]'),
('Headphone', 'Boat Headphone', 900, 51, '["https://m.media-amazon.com/images/I/71ISIssoVFL._AC_UF1000,1000_QL80_.jpg"]'),
('Headphone', 'JBL Headphone', 1200, 23, '["https://m.media-amazon.com/images/I/51ki3TAm5SL._AC_UF1000,1000_QL80_.jpg"]'),
('Laptop', 'Dell Laptop', 45000, 18, '["https://m.media-amazon.com/images/I/51fXuiChdJL._AC_UF1000,1000_QL80_.jpg"]'),
('Laptop', 'HP Laptop', 48000, 31, '["https://m.media-amazon.com/images/I/71HmRBIxSZL._AC_UF1000,1000_QL80_.jpg"]'),
('BedSheet', 'Cotton', 700, 100, '["https://m.media-amazon.com/images/I/A1GkZJgL0gL._AC_UF894,1000_QL80_.jpg"]'),
('Power Bank', 'Power Bank for mobile', 1000, 63, '["https://m.media-amazon.com/images/I/71GfLIrtFUL._AC_UF1000,1000_QL80_.jpg"]'),
('TV', 'Samsung TV', 40000, 15, '["https://m.media-amazon.com/images/I/71S8iUPW9bL._AC_UF1000,1000_QL80_.jpg"]'),
('Chair', 'Plastic chair', 500, 60, NULL),
('Suitcase', 'American Tourister Suitcase', 2000, 33, NULL)
;

INSERT INTO product_category_relation(category_id, product_id)
VALUES
(5, 1),
(5, 2),
(6, 3),
(6, 4),
(7, 5),
(7, 6),
(8, 7),
(6, 8),
(1, 9),
(3, 9),
(2, 10),
(2, 11);

INSERT INTO users(name, username, password, usertype, mobile_no)
VALUES
("name1", "username1", "password1", "Adminstrator", 9876543210),
("name2", "username2", "password2", "Shopper", 9876543211),
("name3", "username3", "password3", "Shopper", 9876543212),
("name4", "username4", "password4", "Shopper", 9876543213);

INSERT INTO address(user_id, address, city, state, zipcode)
VALUES
(1, "Pratap Nagar", "Jaipur", "Rajasthan", 123456),
(2, "Sitapura", "Jaipur", "Rajasthan", 123455),
(3, "Malviya Nagar", "Jaipur", "Rajasthan", 123457),
(3, "Mansarovar", "Jaipur", "Rajasthan", 123458),
(4, "Vaishali Nagar", "Jaipur", "Rajasthan", 123459);

INSERT INTO orders(user_id, address_id, order_date, total_amount)
VALUES
(2, 2, '2024-07-01', 60700),
(3, 3, '2024-06-26', 1200),
(3, 4, '2024-06-15', 45000),
(4, 5, '2024-06-04', 40000)
;

INSERT INTO items(order_id, product_id, quantity, price, status)
VALUES
(1, 1, 2, 60000, "Placed"),
(1, 7, 1, 700, "Shipped"),
(2, 4, 1, 1200, "Shipped"),
(3, 5, 1, 4500, "Cancelled"),
(4, 9, 1, 40000, "Returned");

-- Display Id, Title, Category Title, Price of the products which are Active and recently added products should be at top
SELECT p.id as product_id, p.name as product_name, p.price, r.category_id, c.name as category_name
FROM product p
INNER JOIN product_category_relation r
ON p.id = r.product_id AND quantity > 0
INNER JOIN category c
ON r.category_id = c.id
ORDER BY p.id DESC;

-- Display the list of products which don't have any images.
SELECT id as product_id, name
FROM product
WHERE image_urls IS NULL;

/* 
Display all Id, Title and Parent Category Title for all the Categories listed
sorted by Parent Category Title and then Category Title. 
(If Category is top category then Parent Category Title column should display “Top Category” as value.)
*/
SELECT child.id as category_id, child.name, IFNULL(parent.name, "Top Category") as parent_category
FROM category child
LEFT JOIN category parent
ON child.parent_id = parent.id
ORDER BY parent.name, child.name;

/*
Display Id, Title, Parent Category Title of all the leaf Categories 
(categories which are not parent of any other category)
*/
SELECT child.id as category_id, child.name, IFNULL(parent.name, "Top Category") as parent_category
FROM category child
LEFT JOIN category parent
ON child.parent_id = parent.id
WHERE child.id NOT IN(SELECT id FROM category WHERE parent_id IS NULL);

-- Display Product Title, Price & Description which falls into particular category Title (i.e. “Mobile”)
SELECT p.name as product_title, p.price, p.description
FROM product p, category c, product_category_relation pc
WHERE c.name = 'mobile' AND c.id = pc.category_id AND pc.product_id = p.id;

-- Display the list of Products whose Quantity on hand (Inventory) is under 50
SELECT name, quantity
FROM product
WHERE quantity < 50;


