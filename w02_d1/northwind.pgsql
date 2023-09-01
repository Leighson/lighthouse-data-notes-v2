/* INTRODUCTION TO POSTGRESQL */

-- Task 1: Write a query that returns a product name and its quantity/unit.
-- SELECT productid, productname, quantityperunit FROM products

-- Task 2: Write a query to select all product names and their category ID.
-- SELECT productname, categoryid FROM products

-- Task 3: Write a query to get the firstname, lastname, and hiredate
-- for employees who have been working at their company for more than five years.
-- SELECT firstname, lastname, hiredate FROM employees


/* PRACTICE */
SELECT
  customers.contactname,
  customers.country,
  requireddate,
  shippeddate,
  SUM(requireddate-shippeddate) OVER (PARTITION BY customers.country),
  ROUND(AVG(requireddate-shippeddate) OVER (PARTITION BY customers.country), 2),
  COUNT(requireddate-shippeddate) OVER (PARTITION BY customers.country)
FROM orders
JOIN customers ON customers.customerid = orders.customerid