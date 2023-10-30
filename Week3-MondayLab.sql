USE sakila;
#Determine the number of copies of the film "Hunchback Impossible" that exist in the inventory system.

select film_id
from film
where title LIKE "Hunchback Impossible";


SELECT count(inventory_id) 
from inventory
Where film_id  = (
select film_id
from film
where title LIKE "Hunchback Impossible"
);

#List all films whose length is longer than the average length of all the films in the Sakila database.
Select avg(length)
from sakila.film;

SELECT *
FROM sakila.film
WHERE length > (Select avg(length) from sakila.film);

#Use a subquery to display all actors who appear in the film "Alone Trip".

SELECT film_id
from sakila.film
WHERE title = "Alone Trip";

SELECT actor_id
from film_actor
WHERE film_id IN (
	SELECT film_id
from sakila.film
WHERE title = "Alone Trip");

SELECT first_name, last_name 
FROM actor
WHERE actor_id IN (
	SELECT actor_id
from film_actor
WHERE film_id IN (
	SELECT film_id
from sakila.film
WHERE title = "Alone Trip"))
;
#bonus
#Sales have been lagging among young families, and you want to target family movies for a promotion. Identify all movies categorized as family films.

SELECT category_id 
FROM category
WHERE name = "Family";

SELECT film_id
FROM film_category
WHERE category_id IN ( SELECT category_id 
FROM category
WHERE name = "Family");

SELECT title
FROM film
WHERE film_id IN (SELECT film_id
FROM film_category
WHERE category_id IN ( SELECT category_id 
FROM category
WHERE name = "Family"));

#Retrieve the name and email of customers from Canada using both subqueries and joins. To use joins, you will need to identify the relevant tables and their primary and foreign keys.

SELECT country_id
FROM country
WHERE country = "Canada";

SELECT address_id
FROM city
JOIN address 
USING (city_id) 
WHERE country_id in (SELECT country_id
FROM country
WHERE country = "Canada");

SELECT first_name, last_name, email
FROM customer
WHERE address_id in (SELECT address_id
FROM city
JOIN address 
USING (city_id) 
WHERE country_id in (SELECT country_id
FROM country
WHERE country = "Canada"));

#Determine which films were starred by the most prolific actor in the Sakila database. A prolific actor is defined as the actor who has acted in the most number of films. First, you will need to find the most prolific actor and then use that actor_id to find the different films that he or she starred in.

SELECT actor.actor_id, actor.last_name, actor.first_name, COUNT(film_actor.film_id) as No_films
FROM sakila.actor
JOIN sakila.film_actor
ON sakila.actor.actor_id = sakila.film_actor.actor_id
GROUP BY film_actor.actor_id
ORDER BY No_films DESC
LIMIT 1;

SELECT film_id
FROM film_actor
WHERE actor_id = 107;

SELECT title
from film
WHERE film_id IN (SELECT film_id
FROM film_actor
WHERE actor_id = 107);


#7

SELECT film_id, title, customer_id
FROM customer 
JOIN rental
USING (customer_id)
JOIN inventory 
USING (inventory_id)
JOIN film
USING (film_id)
WHERE customer_id = (
    SELECT customer_id
    FROM customer
    JOIN payment
    USING (customer_id)
    GROUP BY customer_id
    ORDER BY SUM(amount) DESC
    LIMIT 1
);




