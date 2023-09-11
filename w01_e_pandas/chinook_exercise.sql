/* SQL Exercise
====================================================================
We will be working with database chinook.db
You can download it here:
https://drive.google.com/file/d/0Bz9_0VdXvv9bWUtqM0NBYzhKZ3c/view?usp=sharing&resourcekey=0-7zGUhDz0APEfX58SA8UKog

The Chinook Database is about an imaginary video and music store.
Each track is stored using one of the digital formats and has a genre.
The store has also some playlists, where a single track can be part of
several playlists. Orders are recorded for customers, but are called invoices.
Every customer is assigned a support employee,
and Employees report to other employees.
*/

-- MAKE YOURSELF FAIMLIAR WITH THE DATABASE AND TABLES HERE

--==================================================================
/* TASK I
Which artists did not make any albums at all? Include their names in your answer.
*/
-- SELECT DISTINCT(artists.Name) FROM artists
-- LEFT JOIN  albums ON artists.ArtistId = albums.ArtistId
-- WHERE albums.Title IS NULL
-- ORDER BY artists.Name

/* TASK II
Which artists recorded any tracks of the Latin genre?
*/
-- SELECT artists.Name AS Artist, tracks.Name AS Track, genres.Name AS Genre FROM tracks
-- JOIN albums ON tracks.AlbumId = albums.AlbumId
-- JOIN artists ON albums.ArtistId = artists.ArtistId
-- JOIN genres ON tracks.GenreId = genres.GenreId
-- WHERE Genre = 'Latin'
-- ORDER BY Artist, Track


/* TASK III
Which video track has the longest length?
*/
-- SELECT
--   artists.Name AS Artist,
--   tracks.Name AS Track,
--   media_types.Name AS MediaType,
--   tracks.Milliseconds/1000 AS TrackLength
-- FROM tracks
-- JOIN media_types ON media_types.MediaTypeId = tracks.MediaTypeId
-- JOIN albums on albums.AlbumId = tracks.AlbumId
-- JOIN artists on artists.ArtistId = albums.ArtistId
-- WHERE MediaType IS 'Protected MPEG-4 video file'
-- ORDER BY TrackLength DESC
-- LIMIT 1

/* TASK IV
Find the names of customers who live in the same city as the top employee.
(The one not managed by anyone).
*/
-- SELECT
--   customers.FirstName || ' ' || customers.LastName AS 'FullName',
--   customers.City,
--   COUNT(customers.City) AS 'CityCount'
-- FROM customers
-- WHERE customers.City = (
--   SELECT employees.City FROM employees
--   WHERE employees.ReportsTo IS NULL)
-- GROUP BY customers.City

/* TASK V
Find the managers of employees supporting Brazilian customers.
*/
-- SELECT FirstName || ' ' || LastName AS FullName FROM employees
-- WHERE employees.EmployeeId IN (
--   SELECT employees.ReportsTo FROM employees
--   WHERE employees.EmployeeId IN (
--     SELECT customers.SupportRepID FROM customers
--     WHERE customers.Country = 'Brazil'))

/* TASK VI
Which playlists have no Latin tracks?
*/
SELECT * FROM playlists
WHERE playlists.PlaylistId IN (
  SELECT DISTINCT(playlist_track.PlaylistId) FROM playlist_track
  JOIN tracks ON tracks.TrackId = playlist_track.TrackId
  JOIN genres ON genres.GenreId = tracks.GenreId
  WHERE genres.Name IS NOT 'Latin')