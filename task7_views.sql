USE ecommerce_db;
-- View 1: Customer Order Summary
CREATE VIEW customer_order_summary AS
SELECT c.CustomerID, c.Name, COUNT(o.OrderID) AS total_orders, SUM(o.TotalAmount) AS total_spent
FROM customers c
JOIN orders o ON c.CustomerID = o.CustomerID
GROUP BY c.CustomerID;

-- View 2: Product Sales Overview
CREATE VIEW product_sales_summary AS
SELECT p.ProductID, p.ProductName, SUM(oi.Quantity) AS total_quantity_sold
FROM products p
JOIN orderitems oi ON p.ProductID = oi.ProductID
GROUP BY p.ProductID;

-- View 3: High Value Customers (who spent more than 10,000)
CREATE VIEW high_value_customers AS
SELECT * FROM customer_order_summary
WHERE total_spent > 10000;

-- View 4: Payments by Method
CREATE VIEW payments_by_method AS
SELECT PaymentMethod, COUNT(*) AS total_payments, SUM(Amount) AS total_collected
FROM payments
GROUP BY PaymentMethod;

-- View 5: Orders with Payment Info
CREATE VIEW order_payment_details AS
SELECT o.OrderID, o.CustomerID, o.TotalAmount, p.PaymentDate, p.PaymentMethod
FROM orders o
JOIN payments p ON o.OrderID = p.OrderID;

-- 💡 Example: Using a View
SELECT * FROM high_value_customers;
SELECT * FROM product_sales_summary WHERE total_quantity_sold > 5;

