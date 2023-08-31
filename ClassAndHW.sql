-- How many rentals did each staff member sold

SELECT first_name, last_name, staff.staff_id, COUNT(staff.staff_id)
FROM staff
FULL JOIN rental
ON staff.staff_id = rental.staff_id
WHERE staff.staff_id IS NOT NULL
GROUP BY staff.staff_id;

-- Inner join to find which actors are in what films by id 

SELECT actor.actor_id first_name, last_name, film_id
FROM film_actor
INNER JOIN actor
ON actor.actor_id = film_actor.actor_id;

--Adding another join to get the title of the fil each actor starred in

SELECT actor.actor_id first_name, last_name, film.film_id, title, description
FROM film_actor
INNER JOIN actor
ON actor.actor_id = film_actor.actor_id
INNER JOIN film
ON film_actor.film_id = film.film_id;

--Find all customers who live in angola
--Start with customer table and get to the country table
--customer to address to city to country

SELECT customer_id, first_name, last_name, country
From customer
INNER JOIN address
ON address.address_id = customer.address_id
INNER JOIN city
ON city.city_id = address.city_id
INNER JOIN country
ON country.country_id = city.country_id
WHERE country = 'Angola'

-- Subquery is query within a query where a primary exist as a foreign key in another table
-- find a customer_ that has paid an amout greater than 175

SELECT customer_id Sum(amount)
FROM payment
GROUP BY customer_id
Having SUM(amount) >175
Order By Sum(amount) DESC;

SELECT *
FROM customer;

-- Sub Query Example
SELECT store_id, first_name, last_name
FROM customer
WHERE customer_id IN( -- the query within the query
	SELECT customer_id
	FROM payment
	GROUP BY customer_id
	HAVING SUM (amount) > 175
	ORDER BY SUM (amount) DESC
);

-- Join Version

SELECT first_name, last_name, Sum(amount)
FROM customer
INNER JOIN payment
ON customer.customer_id = payment.customer_id
GROUP BY first_name, last_name
HAVING SUM (amount) > 175
ORDER BY SUM (amount DESC); --

SELECT first_name, last_name, SUM(amount)
FROM customer
INNER JOIN payment
ON customer.customer_id = payment.customer_id
GROUP BY first_name, last_name
HAVING SUM(amount) > 175
ORDER BY SUM(amount) DESC;

--Subquery 
-- find all films with that are english

SELECT *
FROM film
WHERE language_id IN (
	SELECT language_id
	FROM language
	WHERE name = 'English'
);

SELECT *
FROM film;

SELECT *
FROM payment;

-- List all customers who live in texas
-- customer to address district

-- 1
SELECT customer_id, first_name, last_name, district
FROM customer
INNER JOIN address
ON customer.address_id = address.address_id
WHERE district = 'Texas';

--2 Get all payments above $6.99 with the customers full name
--customer to pyment using customer_id

SELECT first_name, last_name, amount
FROM customer
INNER JOIN payment
ON customer.customer_id = payment.customer_id
GROUP BY first_name, last_name, amount
HAVING (amount) > 6.99;


-- 3 Show all customers names that made payments over $175

SELECT first_name, last_name, customer_id
FROM customer
WHERE customer_id IN(
	SELECT customer_id
	FROM payment
	GROUP BY customer_id
	HAVING SUM(amount) >175
	ORDER BY SUM(amount) DESC
);
-- 4 List all customers that live in Nepal
--customer

SELECT customer_id, first_name, last_name, country
From customer
INNER JOIN address
ON address.address_id = customer.address_id
INNER JOIN city
ON city.city_id = address.city_id
INNER JOIN country
ON country.country_id = city.country_id
WHERE country = 'Nepal'


-- 5 Which staff member had the most transactions

SELECT first_name, last_name, staff.staff_id, COUNT(staff.staff_id)
FROM staff
INNER JOIN rental
ON staff.staff_id = rental.staff_id
GROUP BY staff.staff_id
LIMIT 1;


-- 6 How many movies of each rating are there

SELECT  rating, COUNT(rating)
FROM film
Group By rating;

-- 7 Show all customers who made a single payment above $6.99 -- Need to finish


SELECT customer_id, first_name, last_name
FROM customer
WHERE customer_id IN(
	SELECT payment.customer_id
	FROM payment
	WHERE payment.amount > 6.99
	GROUP BY payment.customer_id
	HAVING COUNT(payment.payment_id) = 1);


SELECT first_name, last_name, amount
FROM customer
INNER JOIN payment
ON customer.customer_id = payment.customer_id
GROUP BY first_name, last_name, amount
HAVING (amount) = 6.99;

-- 8 How many free rentals did our stores give away

SELECT COUNT(amount)
FROM payment
WHERE amount = 0;
