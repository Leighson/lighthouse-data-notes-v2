/* SQL Stretch Exercise
====================================================================
We will be working with database chinook.db
You can download it here:
https://drive.google.com/file/d/0Bz9_0VdXvv9bWUtqM0NBYzhKZ3c/view?usp=sharing&resourcekey=0-7zGUhDz0APEfX58SA8UKog

The Chinook Database is about an imaginary video and music store.
Each track is stored using one of the digital formats and has a genre.
The store has also some playlists, where a single track can be part of
several playlists. Orders are recorded for customers, but are called invoices.
Every customer is assigned a support employee, and Employees report to other employees.
*/

--==================================================================
/* TASK I
How many audio tracks in total were bought by German customers?
And what was the total price paid for them?
HINT: use subquery to find all of tracks with their prices
*/

-- SELECT *
--   -- ,COUNT(Quantity) /* 146 */
--   -- ,SUM(UnitPrice) /* 144.56 */
-- FROM invoice_items
-- WHERE invoice_items.InvoiceId IN (
--   SELECT invoices.InvoiceId FROM invoices
--   WHERE invoices.customerId IN (
--     SELECT customers.CustomerId FROM customers
--     WHERE customers.Country = 'Germany'))
-- AND invoice_items.TrackId IN (
--   SELECT tracks.TrackId FROM tracks
--   JOIN media_types ON media_types.MediaTypeId = tracks.MediaTypeId
--   WHERE media_types.MediaTypeId IN(
--     SELECT media_types.MediaTypeId FROM media_types
--     WHERE media_types.Name LIKE '%audio%'))


/* TASK II
What is the space, in bytes, occupied by the playlist “Grunge”, and how much would it cost?
(Assume that the cost of a playlist is the sum of the price of its constituent tracks).
*/

-- SELECT
--   playlists.Name AS PL_name,
--   ROUND(SUM(tracks.Bytes)/1000000,2) AS Space_MB,
--   SUM(tracks.UnitPrice) AS Total_price_$
-- FROM tracks
-- JOIN playlist_track ON playlist_track.TrackId = tracks.TrackId
-- JOIN playlists ON playlists.PlaylistId = playlist_track.PlaylistId
-- WHERE playlists.Name LIKE '%Grunge%'
-- GROUP BY playlists.Name

/* TASK III
List the names and the countries of those customers who were supported by
an employee who was younger than 35 when hired. 
*/

SELECT
  customers.CustomerId,
  customers.FirstName || ' ' || customers.LastName AS FullName,
  customers.Country
FROM customers
WHERE customers.SupportRepId IN (
  SELECT
    employees.EmployeeId
    -- ,(employees.FirstName || ' ' || employees.LastName) AS FullName,
    -- (employees.Country) AS Country,
    -- (employees.HireDate - employees.BirthDate) AS AgeHired
  FROM employees
  WHERE (employees.HireDate - employees.BirthDate) < 35)
ORDER BY CustomerId, FullName

/* END */