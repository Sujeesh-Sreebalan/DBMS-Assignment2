USE StoreFront;

-- Display Recent 50 Orders placed (Id, Order Date, Order Total).
SELECT id, order_date, total_amount
FROM orders
ORDER BY order_date DESC
LIMIT 50;

-- Display 10 most expensive Orders.
SELECT id, total_amount
FROM orders
ORDER BY total_amount DESC
LIMIT 10;

/* 
Display all the Orders which are placed more than 10 days old 
and one or more items from those orders are still not shipped.
*/
SELECT id, total_amount
FROM orders
WHERE order_date >= (CURDATE()-INTERVAL 10 DAY)
AND id IN (SELECT order_id
		   FROM items
           WHERE status="Placed");


-- Display list of shoppers which haven't ordered anything since last month.
SELECT u.id, u.name, o.order_date
FROM users u
INNER JOIN orders o
ON u.id = o.user_id
WHERE u.usertype = 'Shopper' AND u.id NOT IN(SELECT user_id
					     FROM orders
					     WHERE order_date >= (CURDATE()-INTERVAL 1 MONTH));
                                         
# Display list of shopper along with orders placed by them in last 15 days.
SELECT u.id, u.name, o.id, o.order_date
FROM users u
INNER JOIN orders o
ON u.id = o.user_id
WHERE u.usertype = 'Shopper' AND u.id IN(SELECT user_id
			  	    	 FROM orders
                                         WHERE order_date >= (CURDATE() - INTERVAL 15 DAY));
                                         

-- Display list of order items which are in “shipped” state for particular Order Id
SELECT i.id, p.name
FROM product p 
INNER JOIN items i
ON i.product_id = p.id
WHERE i.status = "Shipped";

-- Display list of order items along with order placed date which fall between Rs 20 to Rs 50 price.
SELECT o.id, o.user_id, o.order_date, i.price
FROM orders o
LEFT JOIN items i
ON i.order_id = o.id
WHERE i.price BETWEEN 20 AND 50;
                                         
