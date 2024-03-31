-- SELECT ALL ROOMS THAT ARE CURRENTLY CHECKED IN
SELECT * FROM room
WHERE room_id IN
    (SELECT room_id FROM checks_in);

-- SELECT ALL CUSTOMERS THAT ARE CURRENTLY RENTING A ROOM
SELECT * FROM customer
WHERE sin IN
    (SELECT customer_sin FROM checks_in
    JOIN booking ON checks_in.room_id = booking.room_id AND checks_in.start_date = booking.start_date);

-- RANKS THE CHAINS BASED ON TOTAL NUMBER OF BOOKINGS PER CHAIN
SELECT chain_name, COUNT(chain_name) AS total_bookings
FROM Hotel JOIN Room ON Hotel.id = Room.hotel_id
JOIN Booking ON Room.room_id = Booking.room_id
GROUP BY chain_name
ORDER BY total_bookings DESC;

-- FIND THE AVERAGE LENGTH OF STAY FOR EACH CUSTOMER
SELECT customer_sin, AVG(end_date - start_date) as average_stay
FROM Booking
GROUP BY customer_sin;
