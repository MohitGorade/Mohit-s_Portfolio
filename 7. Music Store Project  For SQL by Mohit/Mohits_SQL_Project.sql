-- Mohit's Project for SQL

-- Create database Music store 
show databases;
create database Music_store;
use Music_store;
select * from artist;
select * from customer;

-- Question Set :-

-- 1. Who is the senior most employee based on job title?

select Employee_id,First_name,last_name,Levels from employee
order by levels desc
limit 1;

-- 2. Which countries have the most Invoices?

select billing_country,count(*) from invoice
group by billing_country
order by count(*) desc;


-- 3. What are top 3 values of total invoice?

select billing_country,total from invoice
order by total desc
limit 3;

-- 4. Which city has the best customers? We would like to throw a promotional Music 
-- Festival in the city we made the most money. Write a query that returns one city that 
-- has the highest sum of invoice totals. Return both the city name & sum of all invoice total ?

select billing_city,sum(total) as sum_total_invoice from invoice
group by billing_city 
order by sum(total) desc
limit 1;

-- 5. Write query to return the email, first name, last name, & Genre of all Rock Music 
-- listeners. Return your list ordered alphabetically by email starting with A
-- Approch 1

select distinct c.Email, c.First_name, c.Last_name from customer as c
join Invoice as i 
on c.customer_id = i.customer_id
join invoice_line as il
on i.invoice_id = il.invoice_id
join track as t
on il.track_id = t.track_id
join genre as g
on t.genre_id = g.genre_id
where  g.name like 'Rock' 
order by c.email;

-- Approch 2

select distinct email,first_name,last_name from customer
join invoice on customer.customer_id = invoice.customer_id
join invoice_line on invoice.invoice_id = invoice_line.invoice_id
where track_id in(
                  select track_id from track
                  join genre
                  on genre.genre_id = track.genre_id
                  where genre.name like 'Rock')
                  order by email;
                  
-- 6: Return all the track names that have a song length longer than the average song length. 
-- Return the Name and Milliseconds for each track. Order by the song length with the longest songs listed first.

select name, milliseconds from track
where milliseconds > (select avg(milliseconds) from track)
order by milliseconds desc;

-- Complete