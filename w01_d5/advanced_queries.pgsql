-- TASK 1:
-- Write a subquery to retrieve all orders where the order date is
-- before the order date of any orders placed by the same customer in the USA,
-- and the total price of the order is greater than $1,000.

-- SELECT (
--   SELECT * FROM orders
--   GROUP BY 
-- ), (
--   SELECT * FROM order_details
-- ) FROM orders

SELECT * FROM orders ord
WHERE
EXISTS (
  SELECT * FROM orders
  WHERE ord.shipcountry = 'USA'
) AND (
  SELECT * FROM order_details det
  WHERE det.unitprice * det.quantity > 1000
)