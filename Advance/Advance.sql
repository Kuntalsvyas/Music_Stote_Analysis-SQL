/* FIND HOW MUCH AMOUNT SPENT BY EACH CUSTOMER ON ARTISTS? WRITE A 
	QUERY TO RETURN CUSTOMER NAME, ARTIST NAME AND TOTAL SPENT*/
	
WITH best_selling_artist AS(
	SELECT 
		r.artist_id AS artist_id , 
		r.name AS artist_name,
		SUM(l.unit_price*l.quantity) AS total_sales 
	FROM invoice_line l
	JOIN track t 	ON t.track_id=l.track_id
	JOIN album a 	ON a.album_id=t.album_id
	JOIN artist r 	ON r.artist_id=a.artist_id
	GROUP BY 1 
	ORDER BY 3 DESC 
	LIMIT 1
)
SELECT 
	c.customer_id,
	c.first_name,
	c.last_name,
	bsa.artist_name,
SUM(l.unit_price*l.quantity) AS amount_spent
FROM invoice i
JOIN customer c 				ON c.customer_id=i.customer_id
JOIN invoice_line l			 	ON l.invoice_id=i.invoice_id
JOIN track t 					ON t.track_id=l.track_id
JOIN album a 					ON a.album_id=t.album_id
JOIN best_selling_artist bsa 	ON bsa.artist_id=a.artist_id
GROUP BY 
	1,2,3,4
ORDER BY 
	5 DESC

-- SOLVE MY DIFFRENT METHOD 

SELECT 
    c.customer_id,
    c.first_name,
    c.last_name,
    ar.name AS artist_name,
    SUM(il.unit_price * il.quantity) AS total_spent
FROM customer c
JOIN invoice i       ON c.customer_id = i.customer_id
JOIN invoice_line il ON i.invoice_id = il.invoice_id
JOIN track t         ON il.track_id = t.track_id
JOIN album al        ON t.album_id = al.album_id
JOIN artist ar       ON al.artist_id = ar.artist_id
GROUP BY 
    c.customer_id,
    c.first_name,
    c.last_name,
    ar.artist_id,
    ar.name
ORDER BY 
    total_spent DESC


/* WE WANT TO FIND OUT THE MOST POPULAR MUSIC GENRE FOR EACH COUNTRY. 
	WE DETERMINE THE MOST POPULAR GENRE AS THE GENRE WITH THE HIGHEST 
	AMOUNT OF PURCHASES. WRITE A QUERY THAT RETURNS EACH COUNTRY ALONG 
	WITH THE TOP GENRE. FOR COUNTRIES WHERE THE MAXIMUM NUMBER OF 
	PURCHASES IS SHARED RETURN ALL GENRES.*/

WITH popular_genre AS
(
    SELECT 
        COUNT(invoice_line.quantity) AS purchases,
        customer.country,
        genre.name,
        genre.genre_id,
        ROW_NUMBER() OVER(
            PARTITION BY customer.country 
            ORDER BY COUNT(invoice_line.quantity) DESC
        ) AS RowNo
    FROM invoice_line
    JOIN invoice 	ON invoice.invoice_id = invoice_line.invoice_id
    JOIN customer 	ON customer.customer_id = invoice.customer_id
    JOIN track 		ON track.track_id = invoice_line.track_id
    JOIN genre 		ON genre.genre_id = track.genre_id
    GROUP BY 
        2, 3, 4
    ORDER BY 
		2 ASC,
		1 DESC
		
)
SELECT * 
FROM popular_genre 
WHERE RowNo <= 1


-- SOLVE WITH DIFFRENT METHOD


SELECT country,genre_name,purchases
FROM(
	SELECT 
	c.country ,
	g.name AS genre_name,
	g.genre_id ,
	COUNT(*) AS purchases,
	RANK() OVER(
		PARTITION BY c.country 
		ORDER BY COUNT(*) DESC
		)AS rnk
FROM genre g
JOIN track t 			ON g.genre_id=t.genre_id
JOIN invoice_line il	ON t.track_id=il.track_id
JOIN invoice i			ON il.invoice_id=i.invoice_id
JOIN customer c 		ON i.customer_id=c.customer_id
GROUP BY 	
	genre_name,
	c.country,
	genre_id
	
) 
WHERE 	
	rnk=1
ORDER BY 
	country

-- SOLVE WITH DIFFRENT METHOD 

WITH RECURSIVE
    sales_per_country AS(
        SELECT COUNT(*) AS purchases_per_genre,
               customer.country,
               genre.name,
               genre.genre_id
        FROM invoice_line
        JOIN invoice ON invoice.invoice_id = invoice_line.invoice_id
        JOIN customer ON customer.customer_id = invoice.customer_id
        JOIN track ON track.track_id = invoice_line.track_id
        JOIN genre ON genre.genre_id = track.genre_id
        GROUP BY 2,3,4
        ORDER BY 2
    ),
    max_genre_per_country AS (
        SELECT MAX(purchases_per_genre) AS max_genre_number,
               country
        FROM sales_per_country
        GROUP BY 2
        ORDER BY 2
    )

SELECT sales_per_country.*
FROM sales_per_country
JOIN max_genre_per_country
    ON sales_per_country.country = max_genre_per_country.country
WHERE sales_per_country.purchases_per_genre = max_genre_per_country.max_genre_number;



/* Write a query that determines the customer that has spent the most on 
music for each country. Write a query that returns the country along with 
the top customer and how much they spent. For countries where the top amount 
spent is shared, provide all customers who spent this amount*/


SELECT customer_id,customer_name,country,total_spent
FROM(
	SELECT 
	c.country ,
	c.customer_id 							AS customer_id,
	(c.first_name || ' ' || c.last_name)  	AS customer_name,
	SUM(il.unit_price*il.quantity) 			AS total_spent,
	RANK() OVER(
		PARTITION BY c.country 
		ORDER BY SUM(il.unit_price*il.quantity) DESC
		)AS rnk
FROM customer c
JOIN invoice i			ON c.customer_id=i.customer_id
JOIN invoice_line il	ON i.invoice_id=il.invoice_id
GROUP BY 	
	c.customer_id,
	customer_name,
	c.country
	
	
) AS X
WHERE 	
	rnk=1
ORDER BY 
	country ;


--METHOD 2

WITH RECURSIVE
customer_with_country AS (
    SELECT 
        customer.customer_id,
        first_name,
        last_name,
        billing_country,
        SUM(total) AS total_spending
    FROM invoice
    JOIN customer 
        ON customer.customer_id = invoice.customer_id
    GROUP BY 1, 2, 3, 4
    ORDER BY 2, 3 DESC
),

country_max_spending AS (
    SELECT 
        billing_country,
        MAX(total_spending) AS max_spending
    FROM customer_with_country
    GROUP BY billing_country
)

SELECT 
    cc.billing_country,
    cc.total_spending,
    cc.first_name,
    cc.last_name,
    cc.customer_id
FROM customer_with_country cc
JOIN country_max_spending ms
    ON cc.billing_country = ms.billing_country
WHERE cc.total_spending = ms.max_spending
ORDER BY 1;

-- METHOD 3

WITH Customter_with_country AS (
    SELECT 
        customer.customer_id,
        first_name,
        last_name,
        billing_country,
        SUM(total) AS total_spending,
        ROW_NUMBER() OVER(
            PARTITION BY billing_country 
            ORDER BY SUM(total) DESC
        ) AS RowNo
    FROM invoice
    JOIN customer 
        ON customer.customer_id = invoice.customer_id
    GROUP BY 1, 2, 3, 4
    ORDER BY 4 ASC, 5 DESC
)
SELECT * 
FROM Customter_with_country 
WHERE RowNo <= 1;
