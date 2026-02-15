/*	WRITE QUERY TO RETURN THE EMAIL, FIRST NAME, LAST NAME, & GENRE OF
	ALL ROCK MUSIC LISTENERS. RETURN YOUR LIST ORDERED ALPHABETICALLY BY
	EMAIL STARTING WITH A.*/

SELECT DISTINCT email,first_name,last_name
FROM customer c 
JOIN invoice i ON c.customer_id=i.customer_id
JOIN invoice_line l ON i.invoice_id=l.invoice_id
WHERE track_id IN(
	SELECT track_id FROM track t
	JOIN genre g ON t.genre_id=g.genre_id
	WHERE g.name LIKE 'Rock'
)
ORDER BY email; 

/*	LET'S INVITE THE ARTISTS WHO HAVE WRITTEN THE MOST ROCK MUSIC IN OUR 
	DATASET.WRITE A QUERY THAT RETURNS THE ARTIST NAME AND TOTAL TRACK 
	COUNT OF THE TOP 10 ROCK BANDS.*/

SELECT r.artist_id,r.name ,COUNT(r.artist_id) as number_of_songs
FROM track t
JOIN album a ON a.album_id=t.album_id
JOIN artist r ON r.artist_id=a.artist_id
JOIN genre g ON g.genre_id=t.genre_id
WHERE g.name LIKE 'Rock'
GROUP BY r.artist_id
ORDER BY number_of_songs DESC
LIMIT 10;

/* RETURN ALL THE TRACK NAMES THAT HAVE A SONG LENGTH LONGER THAN THE 
	AVERAGE SONG LENGTH RETURN THE NAME AND MILLISECONDS FOR EACH TRACK 
	ORDER BY THE SONG LENGTH WITH THE LONGEST SONGS LISTED FIRST.*/

SELECT name, milliseconds FROM track 
WHERE milliseconds>(SELECT AVG(milliseconds) AS avg_legth FROM track)
ORDER BY milliseconds DESC
