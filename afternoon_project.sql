--Practice Joins
--#1
SELECT * FROM invoice
JOIN invoice_line ON invoice_line.invoice_id = invoice.invoice_id
WHERE invoice_line.unit_price > 0.99;

--#2
SELECT i.invoice_date, c.first_name, c.last_name, i.total 
FROM invoice i
JOIN customer c ON i.customer_id = c.customer_id;

--#3
SELECT c.first_name, c.last_name, sr.first_name, sr.last_name
FROM customer c
JOIN employee sr ON c.support_rep_id = sr.employee_id;

--#4
SELECT alb.title, a.name 
FROM album alb
JOIN artist a ON alb.artist_id = a.artist_id;

--#5
SELECT plt.track_id
FROM playlist_track plt
JOIN playlist p ON p.playlist_id = plt.playlist_id
WHERE p.name = 'Music';

--#6
SELECT t.name 
FROM track t
JOIN playlist_track plt ON plt.track_id = t.track_id
WHERE plt.playlist_id = 5;

--#7
SELECT t.name, p.name
FROM track t
JOIN playlist_track pt ON t.track_id = pt.track_id
JOIN playlist p ON pt.playlist_id = p.playlist_id;

--#8
SELECT t.name, a.title
FROM track t
JOIN album a ON t.album_id = a.album_id
JOIN genre g ON g.genre_id = t.genre_id
WHERE g.name = 'Alternative & Punk';

--BLACK DIAMOND


--Practice nested queries
--#1 
SELECT * FROM invoice 
WHERE invoice_id
IN ( SELECT invoice_id
    FROM invoice_line
    WHERE unit_price > 0.99
 );

 --#2
SELECT * FROM playlist_track
WHERE playlist_id 
IN (SELECT playlist_id
    FROM playlist
    WHERE name ='Music'
 );

 --#3
SELECT * FROM track
WHERE track_id 
IN( SELECT track_id
   FROM playlist_track
   WHERE playlist_id = 5
 );

--#4
SELECT * FROM track 
where genre_id
IN (SELECT genre_id 
    FROM genre 
    WHERE name = 'Comedy'
 );

 --#5
SELECT * FROM track
WHERE album_id 
IN (SELECT album_id
    FROM album
    WHERE title = 'Fireball'
 );

 --#6
SELECT * FROM track 
WHERE album_id 
IN (SELECT album_id
    FROM album
    WHERE artist_id
    IN (SELECT artist_id
        FROM artist
        WHERE name = 'Queen'
 ));

 --Practice updating Rows
 --#1
 UPDATE customer 
 SET fax = NULL
 WHERE fax IS NOT NULL;
 --SEE IF IT worked
--  SELECT * FROM customer
--  WHERE fax IS NULL;

--#2
UPDATE customer 
SET company ='Self'
WHERE company IS NULL;

--#3
UPDATE customer 
SET last_name = 'Thompson'
WHERE first_name = 'Julia' AND last_name = 'Barnett';

--#4
UPDATE customer
SET support_rep_id = 4
WHERE email = 'luisrojas@yahoo.cl';

--#5
UPDATE track
SET composer ='The darkness around us'
WHERE genre_id = (SELECT genre_id
                  FROM genre
                  WHERE name = 'Metal'
) AND composer IS NULL;

--Group By
--#1
SELECT COUNT(*), g.name 
FROM track t
JOIN genre g ON t.genre_id = g.genre_id
GROUP BY g.name;

--#2
SELECT COUNT(*), g.name
FROM track t
JOIN genre g ON g.genre_id = t.genre_id
WHERE g.name = 'POP' OR g.name = 'Rock'
GROUP BY g.name;

--#3
SELECT COUNT(*), a.name 
FROM album alb
JOIN artist a ON alb.artist_id = a.artist_id
GROUP BY a.name;

--Use Distinct
--#1
CREATE TABLE practice_delete ( name TEXT, type TEXT, value INTEGER );
INSERT INTO practice_delete ( name, type, value ) VALUES ('delete', 'bronze', 50);
INSERT INTO practice_delete ( name, type, value ) VALUES ('delete', 'bronze', 50);
INSERT INTO practice_delete ( name, type, value ) VALUES ('delete', 'bronze', 50);
INSERT INTO practice_delete ( name, type, value ) VALUES ('delete', 'silver', 100);
INSERT INTO practice_delete ( name, type, value ) VALUES ('delete', 'silver', 100);
INSERT INTO practice_delete ( name, type, value ) VALUES ('delete', 'gold', 150);
INSERT INTO practice_delete ( name, type, value ) VALUES ('delete', 'gold', 150);
INSERT INTO practice_delete ( name, type, value ) VALUES ('delete', 'gold', 150);
INSERT INTO practice_delete ( name, type, value ) VALUES ('delete', 'gold', 150);

SELECT * FROM practice_delete;

--#2
DELETE FROM practice_delete 
WHERE type = 'Silver';

--#3
DELETE FROM practice_delete 
WHERE value = 150;