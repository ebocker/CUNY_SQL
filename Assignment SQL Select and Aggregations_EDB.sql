### Assignment SQL Select and Aggregations
### Emily Bocker

###1. Which destination in the flights database is the furthest distance away, based on information in the flights table. Show the SQL query(s) that support your conclusion.

### ANSWER: IAH (Houston Intercontinental Airport)
### QUERY:
 SELECT dest, max(distance)
FROM flights


# 2. What are the different numbers of engines in the planes table? 
# For each number of engines, which aircraft have the most number of seats? 
# Show the SQL statement(s) that support your result. 

### ANSWER: Planes in this table have 1 - 4 engines. 
### QUERY:
SELECT engines, model, max(seats)
FROM planes
group by engines
order by engines, seats desc


#3.Show the total number of flights. 

### ANSWER: Total Flights: 3844
### QUERY:
SELECT count(DISTINCT flight) as "Total Flights"
FROM flights


#4.Show the total number of flights by airline (carrier).

### QUERY:
SELECT name, count(DISTINCT flight) as "Flights"
FROM flights, airlines
WHERE flights.carrier = airlines.carrier
GROUP BY name
ORDER BY Flights desc


#5. Show all of the airlines, ordered by number of flights in descending order. 

### QUERY:
SELECT name, count(DISTINCT flight) as "Flights"
FROM flights, airlines
WHERE flights.carrier = airlines.carrier
GROUP BY name
ORDER BY Flights desc
LIMIT 5


#6. Show only the top 5 airlines, by number of flights, 
#   ordered by number of flights in descending order. 

### QUERY:
SELECT name, count(DISTINCT flight) as "Flights"
FROM flights, airlines
WHERE flights.carrier = airlines.carrier
GROUP BY name
ORDER BY Flights desc
LIMIT 5


#7. Show only the top 5 airlines, by number of flights of distance 
#   1,000 miles or greater, ordered by number of flights in descending order. 

### QUERY:
SELECT name AS "Airline", count(DISTINCT flight) AS "Flights"
FROM (SELECT flight, carrier
	FROM flights
    WHERE flights.distance >1000) AS a
JOIN airlines 
	ON a.carrier = airlines.carrier
GROUP BY name
ORDER BY Flights desc
LIMIT 5


#8. Create a question that (a) uses data from the flights database, and (b) requires 
#   aggregation to answer it, and write down both the question, and the query that 
#   answers the question. 

### MY QUESTION: 
#   Determine the average Arrival delay time by airline for flights departing from 
#   JFK airport (sort from longest to shortest)

### QUERY:
SELECT p.faa, a.name, avg(f.arr_delay) as "Avg. Delay"
FROM airlines a, airports p, flights f
WHERE a.carrier = f.carrier
	AND f.origin = p.FAA
    AND origin = "JFK"
GROUP BY a.name
ORDER BY avg(f.arr_delay) desc
