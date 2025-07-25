CREATE TABLE Bookings (
    date VARCHAR(10),
    time TIME,
    booking_id VARCHAR(20),
    booking_status VARCHAR(30),
    customer_id VARCHAR(20),
    vehicle_type VARCHAR(20),
    pickup_location VARCHAR(50),
    drop_location VARCHAR(50),
    avg_vtat REAL,
    avg_ctat REAL,
    canceled_rides_by_customer VARCHAR(100),
    canceled_rides_by_driver VARCHAR(100),
    incomplete_rides_reason VARCHAR(100),
    booking_value REAL,
    payment_method VARCHAR(30),
    ride_distance REAL,
    driver_ratings REAL,
    customer_rating REAL
);



COPY Bookings
FROM 'A:\Data\OLA Cabs.csv'
DELIMITER ','
CSV HEADER;

select * from bookings;

--1. Retrieve all successful bookings 
CREATE VIEW successful_bookings AS 
SELECT * FROM bookings
WHERE booking_status ='Success';

SELECT * FROM successful_bookings;

--2. Find the average ride distance for each vehicle type
CREATE VIEW avg_ride_distance_for_each_vehicle AS
SELECT vehicle_type, ROUND(AVG(ride_distance)::numeric, 1) AS avg_distance
FROM bookings
GROUP BY vehicle_type;

SELECT * FROM avg_ride_distance_for_each_vehicle;

--3. Get the total number of cancelled rides by customers
CREATE VIEW cancelled_rides_by_customers AS
SELECT COUNT (*) FROM bookings
WHERE booking_status = 'Cancelled by Customer';

SELECT * FROM cancelled_rides_by_customers;

--4. List the top 5 customers who booked the highest number of rides
CREATE VIEW top_5_customers AS
SELECT Customer_id, COUNT(booking_id) AS total_rides
FROM bookings
GROUP BY customer_id
ORDER BY total_rides DESC LIMIT 5;

SELECT * FROM top_5_customers;

--5. Get the number of rides cancelled by drivers due to personal and car-related issues
CREATE VIEW rides_canceled_by_drivers_p_c_issues AS
SELECT COUNT(*) FROM bookings
WHERE canceled_rides_by_driver = 'Personal & Car related issue';

SELECT * FROM rides_canceled_by_drivers_p_c_issues;

--6. Find the maximum and minimum driver ratings for Prime Sedan bookings
CREATE VIEW Max_Min_Driver_Rating AS
SELECT MAX(driver_ratings) AS max_rating,
       MIN(driver_ratings) AS min_rating
FROM bookings
WHERE vehicle_type = 'Prime Sedan';

SELECT * FROM Max_Min_Driver_Rating;

--7. Retrieve all rides where payment was made using UPI
CREATE VIEW upi_payment AS
SELECT * FROM bookings
WHERE payment_method = 'UPI';

SELECT * FROM upi_payment;

--8. Find the average customer rating per vehicle type
CREATE VIEW vehicle_type_customer_rating AS
SELECT vehicle_type, ROUND(AVG(customer_rating)::numeric, 1) AS avg_rating
FROM bookings
GROUP BY vehicle_type;

SELECT * FROM vehicle_type_customer_rating;

--9. Calculate the total booking value of rides completed successfully
CREATE VIEW total_successful_value AS 
SELECT CAST(SUM(booking_value) AS BIGINT) AS total_successful_value
FROM bookings
WHERE booking_status = 'Success';

SELECT * FROM total_successful_value;

--10. List all incomplete rides along with the reason
CREATE VIEW incomplete_rides_reason AS
SELECT booking_id, incomplete_rides_reason
FROM bookings
WHERE booking_status = 'Incomplete';

SELECT * FROM incomplete_rides_reason;



--1. Retrieve all successful bookings.
SELECT * FROM successful_bookings;

--2. Find the average ride distance for each vehicle type.
SELECT * FROM avg_ride_distance_for_each_vehicle;

--3. Get the total number of cancelled rides by customers.
SELECT * FROM cancelled_rides_by_customers;

--4. List the top 5 customers who booked the highest number of rides.
SELECT * FROM top_5_customers;

--5. Get the number of rides cancelled by drivers due to personal and car-related issues.
SELECT * FROM rides_canceled_by_drivers_p_c_issues;

--6. Find the maximum and minimum driver ratings for Prime Sedan bookings.
SELECT * FROM Max_Min_Driver_Rating;

--7. Retrieve all rides where payment was made using UPI.
SELECT * FROM upi_payment;

--8. Find the average customer rating per vehicle type.
SELECT * FROM vehicle_type_customer_rating;

--9. Calculate the total booking value of rides completed successfully.
SELECT * FROM total_successful_value;

--10. List all incomplete rides along with the reason.
SELECT * FROM incomplete_rides_reason;

