create database aircargo;
use aircargo;
SELECT * from passengers_on_flights WHERE route_id between 0 and 25;
SELECT * FROM customer;
select count(customer_id) AS Number_passengers, sum(Price_per_ticket*no_of_tickets)AS Revenue 
from ticket_details where class_id= "Business";
select concat(first_name," ", last_name) AS name from customer;
select customer.first_name,customer.last_name,customer.customer_id,ticket_details.price_per_ticket 
from customer inner join ticket_details ON customer.customer_id = ticket_details.customer_id; 
select * from ticket_details;
select customer.first_name,customer.last_name,customer.customer_id 
	from customer inner join ticket_details ON customer.customer_id = ticket_details.customer_id 
	where ticket_details.brand= "Emirates";
select customer_id from passengers_on_flights where class_id="Economy plus";
SELECT customer_id,first_name,last_name FROM customer WHERE customer_id 
	IN (SELECT customer_id FROM passengers_on_flights WHERE class_id = "Economy class");
select if(sum(Price_per_ticket*no_of_tickets) >10000  ,' Revenue Crossed 10000', 'Revenue Below 10000') AS revenue 
	from ticket_details;
CREATE USER 'new_user'@'localhost' IDENTIFIED BY 'secure_password';
GRANT ALL PRIVILEGES ON AirCargo.* TO 'new_user'@'localhost';
FLUSH PRIVILEGES;
select max(Price_per_ticket)  OVER (PARTITION BY class_id) AS max_price_per_class FROM ticket_details;
CREATE INDEX Myindex ON passengers_on_flights(route_id);
select * from passengers_on_flight where route_id=4;
SELECT * FROM passengers_on_flights WHERE route_id = 4;
SELECT customer_id, aircraft_id, SUM(no_of_tickets * price_per_ticket) AS total_price 
FROM ticket_details GROUP BY customer_id, aircraft_id WITH ROLLUP;
CREATE VIEW business_class_ AS
SELECT customer_id, brand FROM ticket_details WHERE class_id = 'business';
DELIMITER //
CREATE PROCEDURE get_long_routes()
BEGIN
    SELECT * FROM routes WHERE Distance_miles > 2000;
END //
DELIMITER ;
SELECT customer_id, SUM(no_of_tickets) AS total_tickets_purchased, SUM(no_of_tickets * price_per_ticket) 
AS total_price_paid FROM ticket_details GROUP BY customer_id;
SELECT 
    r.aircraft_id,
    AVG(r.distance_miles) AS avg_distance,
    AVG(passenger_count) AS avg_passengers
FROM routes r
JOIN (
    SELECT 
        route_id,
        aircraft_id,
        COUNT(*) AS passenger_count
    FROM passengers_on_flights
    GROUP BY route_id, aircraft_id
    HAVING COUNT(DISTINCT travel_date) > 1
) pf ON r.route_id = pf.route_id AND r.aircraft_id = pf.aircraft_id
GROUP BY r.aircraft_id;