use music_database;

-- querry1- Who is the senior most employee based on job title?

select employee_id,first_name,last_name,title
from employee
order by levels desc
limit 1;

-- querry 2-  Which countries have the most Invoices?

select billing_country,
count(*) as "No_of_Invoices" 
from invoice
group by billing_country
order by No_of_Invoices desc;

-- querry 3-  What are top 3 values of total invoice?

select invoice_id,customer_id,billing_country,total from invoice
order by total desc
limit 3;

-- querry 4-  Which city has the best customers? We would like to throw a promotional Music 
-- Festival in the city we made the most money. Write a query that returns one city that 
-- has the highest sum of invoice totals. Return both the city name & sum of all invoice totals

select billing_city as "City",
sum(total) as "Total_money" 
from invoice
group by billing_city
order by Total_money desc
limit 1;

-- querry 5-  Who is the best customer? The customer who has spent the most money will be 
-- declared the best customer. Write a query that returns the person who has spent the most money


select c.customer_id,
sum(total) as "total_money"
from customer c 
join invoice i 
using(customer_id)
group by customer_id
order by total_money desc
limit 1;


-- querry 6-  Write query to return the email, first name, last name, & Genre of all Rock Music 
-- listeners. Return your list ordered alphabetically by email starting with A

select distinct c.first_name,c.last_name,c.email ,
g.genre_name as "Genre name",
p.playlist_name as "playlist_name"
from genre g 
join track t
using(genre_id)
join invoice_line il
using(track_id)
join playlist_track pt
using(track_id)
join playlist p 
using(playlist_id)
join invoice i
using(invoice_id)
join customer c
using(customer_id)
where g.genre_name like "Rock" and p.playlist_name like "Music"
order by email ;


select  distinct c.first_name,c.last_name,c.email 
from customer c
join invoice i 
using(customer_id)
join invoice_line
using(invoice_id)
where track_id in 
(select track_id from track t
join genre g
using(genre_id)
where g.genre_name like "Rock")
order by email;



-- querry 7- Write a query to invite the artists who have written the most rock music in our dataset.

select artist_id,
count(artist_id)as "total_track_count"
from artist a
join album al
using(artist_id)
join track t
using(album_id)
join genre g
using(genre_id)
where g.genre_name like "Rock"
group by a.artist_id
order by total_track_count desc;


-- querry 8- Return all the track names that have a song length longer than the average song length. 
-- Return the Name and Milliseconds for each track. Order by the song length with the longest songs listed first

select name as "track_name",milliseconds,
(milliseconds/60000) as "song_duration_in minutes"
from track
where milliseconds>
(select avg(milliseconds) as "song length" 
from track)
order by milliseconds desc;


