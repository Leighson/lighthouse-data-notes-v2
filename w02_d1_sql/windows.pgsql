-- SELECT
--   product_groups.group_name,
--   ROUND(AVG(products.price), 2)
-- FROM products
-- JOIN product_groups USING (group_id)
-- GROUP BY product_groups.group_name

SELECT
  product_name,
  price,
  group_name,
  -- GROUP BY would perform the function below, but it would reduce rows by
  -- consolidating the group_name, thereby removing rows that show
  -- useful information in the columns 'product_name' and 'price' */
  -- ROW_NUMBER() OVER (PARTITION BY group_name ORDER BY price),
  -- RANK() OVER (PARTITION BY group_name ORDER BY price),
  -- DENSE_RANK() OVER (PARTITION BY group_name ORDER BY price),
  ROUND(AVG(price) OVER (PARTITION BY group_name), 1) AS avg_price,
  ROUND(AVG(price) OVER (PARTITION BY group_name) - price, 2) AS product_value,
  LAG(price,1) OVER (PARTITION BY group_name ORDER BY price) - price AS diff
FROM
  products
JOIN product_groups USING (group_id)

-- PARTITION BY distributes the rows of the result set into groups
-- and the AVG() function is applied to each group.


