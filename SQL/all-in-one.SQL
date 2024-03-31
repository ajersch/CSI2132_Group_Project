DROP VIEW IF EXISTS Area_Rooms;
DROP VIEW IF EXISTS Num_Rooms;

DROP TABLE IF EXISTS Checks_In_Archive;
DROP TABLE IF EXISTS Checks_In;
DROP TABLE IF EXISTS Booking_Archive;
DROP TABLE IF EXISTS Booking;
DROP TABLE IF EXISTS Chain_Phone;
DROP TABLE IF EXISTS Chain_Email;
DROP TABLE IF EXISTS Hotel_Phone;
DROP TABLE IF EXISTS Hotel_Email;
DROP TABLE IF EXISTS Room_Amenities;
DROP TABLE IF EXISTS Room_Features;
DROP TABLE IF EXISTS Room_Issues;
DROP TABLE IF EXISTS Customer;
DROP TABLE IF EXISTS Employee_Roles;
DROP TABLE IF EXISTS Supervises;
DROP TABLE IF EXISTS Works_For;
DROP TABLE IF EXISTS Employee;
DROP TABLE IF EXISTS Room;
DROP TABLE IF EXISTS Hotel;
DROP TABLE IF EXISTS Chain;

CREATE TABLE Chain (
                       street_number int NOT NULL CHECK ( street_number > 0),
                       street_name varchar(20) NOT NULL,
                       city varchar(20) NOT NULL,
                       country varchar(20) NOT NULL,
                       name varchar(100),
                       archived boolean NOT NULL DEFAULT FALSE,
                       PRIMARY KEY (name)
);

CREATE TABLE Chain_Phone (
                             chain_name varchar(100),
                             phone int,
                             PRIMARY KEY (chain_name, phone),
                             FOREIGN KEY (chain_name) REFERENCES Chain(name)
);

CREATE TABLE Chain_Email (
                             chain_name varchar(100),
                             email varchar(100) CHECK ( email LIKE '_%@_%._%'),
                             PRIMARY KEY (chain_name, email),
                             FOREIGN KEY (chain_name) REFERENCES Chain(name)
);

CREATE TABLE Hotel (
                       id SERIAL,
                       street_number int NOT NULL CHECK ( street_number > 0),
                       street_name varchar(100) NOT NULL,
                       city varchar(20) NOT NULL,
                       country varchar(20) NOT NULL,
                       chain_name varchar(100) NOT NULL,
                       name varchar(100) NOT NULL,
                       stars int NOT NULL CHECK (stars >= 1 AND stars <= 5),
                       archived boolean NOT NULL DEFAULT FALSE,
                       PRIMARY KEY (id),
                       FOREIGN KEY (chain_name) REFERENCES Chain(name)
);

CREATE TABLE Hotel_Phone (
                             hotel_id int,
                             phone int,
                             PRIMARY KEY (hotel_id, phone),
                             FOREIGN KEY (hotel_id) REFERENCES Hotel(id)
);

CREATE TABLE Hotel_Email (
                             hotel_id int,
                             email varchar(100) CHECK ( email LIKE '_%@_%._%'),
                             PRIMARY KEY (hotel_id, email),
                             FOREIGN KEY (hotel_id) REFERENCES Hotel(id)
);

CREATE TABLE Room (
                      room_id SERIAL,
                      hotel_id int NOT NULL,
                      price float NOT NULL CHECK ( price > 0),
                      capacity int NOT NULL CHECK ( capacity > 0),
                      extendable boolean NOT NULL,
                      room_number int NOT NULL CHECK ( room_number > 0),
                      archived boolean NOT NULL DEFAULT FALSE,
                      PRIMARY KEY (room_id),
                      FOREIGN KEY (hotel_id) REFERENCES Hotel(id)
);

CREATE TABLE Room_Amenities (
                                room_id int,
                                amenity varchar(20),
                                PRIMARY KEY (room_id, amenity),
                                FOREIGN KEY (room_id) REFERENCES Room(room_id)
);

CREATE TABLE Room_Features (
                               room_id int,
                               feature varchar(20),
                               PRIMARY KEY (room_id, feature),
                               FOREIGN KEY (room_id) REFERENCES Room(room_id)
);

CREATE TABLE Room_Issues (
                             room_id int,
                             issue varchar(100),
                             PRIMARY KEY (room_id, issue),
                             FOREIGN KEY (room_id) REFERENCES Room(room_id)
);

CREATE TABLE Customer (
                          sin int,
                          first_name varchar(20) NOT NULL,
                          last_name varchar(20) NOT NULL,
                          street_number int NOT NULL,
                          street_name varchar(20) NOT NULL,
                          city varchar(20) NOT NULL,
                          country varchar(20) NOT NULL,
                          registration_date date NOT NULL CHECK ( registration_date <= CURRENT_DATE),
                          archived boolean NOT NULL DEFAULT FALSE,
                          PRIMARY KEY (sin)
);

CREATE TABLE Employee (
                          sin int,
                          first_name varchar(20) NOT NULL,
                          last_name varchar(20) NOT NULL,
                          street_number int NOT NULL,
                          street_name varchar(20) NOT NULL,
                          city varchar(20) NOT NULL,
                          country varchar(20) NOT NULL,
                          archived boolean NOT NULL DEFAULT FALSE,
                          PRIMARY KEY (sin)
);

CREATE TABLE Employee_Roles (
                                employee_sin int,
                                role varchar(20),
                                PRIMARY KEY (employee_sin, role),
                                FOREIGN KEY (employee_sin) REFERENCES Employee(sin)
);

CREATE TABLE Supervises (
                            employee_sin int,
                            supervisor_sin int,
                            PRIMARY KEY (employee_sin, supervisor_sin),
                            FOREIGN KEY (employee_sin) REFERENCES Employee(sin),
                            FOREIGN KEY (supervisor_sin) REFERENCES Employee(sin)
);

CREATE TABLE Works_For (
                           hotel_id int,
                           employee_sin int,
                           PRIMARY KEY (hotel_id, employee_sin),
                           FOREIGN KEY (hotel_id) REFERENCES Hotel(id),
                           FOREIGN KEY (employee_sin) REFERENCES Employee(sin)
);

CREATE TABLE Booking (
                         room_id int,
                         start_date date,
                         end_date date NOT NULL CHECK ( end_date > start_date),
                         customer_sin int NOT NULL,
                         PRIMARY KEY (room_id, start_date),
                         FOREIGN KEY (room_id) REFERENCES Room(room_id),
                         FOREIGN KEY (customer_sin) REFERENCES Customer(sin)
);

CREATE TABLE Booking_Archive (
                                 room_id int,
                                 start_date date,
                                 end_date date NOT NULL CHECK ( end_date > start_date),
                                 customer_sin int NOT NULL,
                                 PRIMARY KEY (room_id, start_date),
                                 FOREIGN KEY (room_id) REFERENCES Room(room_id),
                                 FOREIGN KEY (customer_sin) REFERENCES Customer(sin)
);

CREATE TABLE Checks_In (
                           room_id int,
                           start_date date,
                           employee_sin int NOT NULL,
                           PRIMARY KEY (room_id, start_date),
                           FOREIGN KEY (room_id, start_date) REFERENCES Booking(room_id, start_date) ON DELETE CASCADE,
                           FOREIGN KEY (employee_sin) REFERENCES Employee(sin)
);

CREATE TABLE Checks_In_Archive (
                                   room_id int,
                                   start_date date,
                                   employee_sin int NOT NULL,
                                   PRIMARY KEY (room_id, start_date),
                                   FOREIGN KEY (room_id, start_date) REFERENCES Booking_Archive(room_id, start_date),
                                   FOREIGN KEY (employee_sin) REFERENCES Employee(sin)
);

CREATE VIEW Num_Rooms AS
SELECT Hotel.id, Hotel.name, COUNT(Room.room_id) AS hotel_rooms
FROM Hotel JOIN Room ON Hotel.id = Room.hotel_id
WHERE Room.archived = FALSE
  AND Hotel.archived = FALSE
GROUP BY Hotel.id;

CREATE VIEW Area_Rooms AS
SELECT Hotel.city, SUM(hotel_rooms) AS total_rooms
FROM Hotel JOIN Num_Rooms ON Hotel.id = Num_Rooms.id
GROUP BY Hotel.city;

CREATE INDEX Booking_Start ON Booking(start_date);
CREATE INDEX Booking_End ON Booking(end_date);
CREATE INDEX Room_Price ON Room(price);

-- Archives all hotels in a chain when the chain is archived
CREATE OR REPLACE FUNCTION chain_archiver() RETURNS TRIGGER AS $$
BEGIN
    IF NEW.archived THEN
        UPDATE Hotel SET archived = TRUE WHERE Hotel.chain_name = NEW.name;
    END IF;
    RETURN NEW;
END;
$$ language plpgsql;

CREATE TRIGGER chain_archiver
    AFTER UPDATE OF archived ON Chain
    FOR EACH ROW
EXECUTE FUNCTION chain_archiver();

-- Archives all rooms in a hotel when the hotel is archived
CREATE OR REPLACE FUNCTION hotel_archiver() RETURNS TRIGGER AS $$
BEGIN
    IF NEW.archived THEN
        UPDATE Room SET archived = TRUE WHERE Room.hotel_id = NEW.id;
    END IF;
    RETURN NEW;
END;
$$ language plpgsql;

CREATE TRIGGER hotel_archiver
    AFTER UPDATE OF archived ON Hotel
    FOR EACH ROW
EXECUTE FUNCTION hotel_archiver();

-- Deletes all bookings for a room when the room is deleted
CREATE OR REPLACE FUNCTION room_archiver() RETURNS TRIGGER AS $$
BEGIN
    DELETE FROM Booking WHERE Booking.room_id = NEW.room_id;
    RETURN NEW;
END;
$$ language plpgsql;

CREATE TRIGGER room_archiver
    AFTER UPDATE OF archived ON Room
    FOR EACH ROW
EXECUTE FUNCTION room_archiver();

-- Creates an archive of all bookings when a booking is made
CREATE OR REPLACE FUNCTION booking_archiver() RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO Booking_Archive VALUES (NEW.room_id, NEW.start_date, NEW.end_date, NEW.customer_sin);
    RETURN NEW;
end;
$$ language plpgsql;

CREATE TRIGGER booking_archiver
    AFTER INSERT ON Booking
    FOR EACH ROW
EXECUTE FUNCTION booking_archiver();


CREATE OR REPLACE FUNCTION check_in_archiver() RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO Checks_In_Archive VALUES (NEW.room_id, NEW.start_date, NEW.employee_sin);
    RETURN NEW;
end;
$$ language plpgsql;

-- Creates an archive of all check-ins when a check-in is made
CREATE TRIGGER check_in_archiver
    AFTER INSERT ON Checks_In
    FOR EACH STATEMENT
EXECUTE FUNCTION check_in_archiver();

-- Ensures that a room number is unique within a hotel
CREATE OR REPLACE FUNCTION unique_room_number() RETURNS TRIGGER AS $$
BEGIN
    IF EXISTS (SELECT * FROM Room WHERE Room.hotel_id = NEW.hotel_id AND Room.room_number = NEW.room_number) THEN
        RAISE EXCEPTION 'Room number must be unique within a hotel';
    END IF;
    RETURN NEW;
END;
$$ language plpgsql;

CREATE TRIGGER unique_room_number
    BEFORE INSERT ON Room
    FOR EACH ROW
EXECUTE FUNCTION unique_room_number();

-- Removes bookings from a deleted customer
CREATE OR REPLACE FUNCTION customer_archiver() RETURNS TRIGGER AS $$
BEGIN
    IF NEW.archived THEN
        DELETE FROM Booking WHERE Booking.customer_sin = NEW.sin;
    END IF;
    RETURN OLD;
END;
$$ language plpgsql;

CREATE TRIGGER customer_archiver
    AFTER UPDATE OF archived ON Customer
    FOR EACH ROW
EXECUTE FUNCTION customer_archiver();

INSERT INTO Chain (street_number, street_name, city, country, name, archived)
VALUES (100, 'Queen Street', 'Toronto', 'Canada', 'ACR_Mart', FALSE),
       (200, 'Robson Street', 'Vancouver', 'Canada', 'ACR_Honors', FALSE),
       (300, 'Rue Sainte-Catherine', 'Montreal', 'Canada', 'ACR_Suites', FALSE),
       (400, 'Portage Avenue', 'Winnipeg', 'Canada', 'ACR_Camp', FALSE),
       (500, 'Granville Street', 'Calgary', 'Canada', 'ACR_Lodge', FALSE);

-- Inserting phone numbers and emails for chains

-- Inserting phone numbers and email for ACR_Mart
INSERT INTO Chain_Phone (chain_name, phone)
VALUES ('ACR_Mart', 1234567890);

INSERT INTO Chain_Email (chain_name, email)
VALUES ('ACR_Mart', 'acrmart@ACR_Mart.com');

-- Inserting phone numbers and email for ACR_Honors
INSERT INTO Chain_Phone (chain_name, phone)
VALUES ('ACR_Honors', 1345678901);

INSERT INTO Chain_Email (chain_name, email)
VALUES ('ACR_Honors', 'acrhonors@ACR_Honors.com');

-- Inserting phone numbers and email for ACR_Suites
INSERT INTO Chain_Phone (chain_name, phone)
VALUES ('ACR_Suites', 1456789012);

INSERT INTO Chain_Email (chain_name, email)
VALUES ('ACR_Suites', 'aces@ACR_Suites.com');

-- Inserting phone numbers and email for ACR_Camp
INSERT INTO Chain_Phone (chain_name, phone)
VALUES ('ACR_Camp', 1567890123);

INSERT INTO Chain_Email (chain_name, email)
VALUES ('ACR_Camp', 'acp@ACR_Camp.com');

-- Inserting phone numbers and email for ACR_Lodge
INSERT INTO Chain_Phone (chain_name, phone)
VALUES ('ACR_Lodge', 1678901234);

INSERT INTO Chain_Email (chain_name, email)
VALUES ('ACR_Lodge', 'ae@ACR_Lodge.com');

-- Inserting hotels for ACR_Mart (Toronto)
INSERT INTO Hotel (street_number, street_name, city, country, chain_name, name, stars, archived)
VALUES (1, 'King Street', 'Toronto', 'Canada', 'ACR_Mart', 'ACR Mart Toronto 1', 4, FALSE),
       (2, 'Queen Street', 'Toronto', 'Canada', 'ACR_Mart', 'ACR Mart Toronto 2', 3, FALSE),
       (3, 'Yonge Street', 'Toronto', 'Canada', 'ACR_Mart', 'ACR Mart Toronto 3', 5, FALSE),
       (4, 'Bay Street', 'Toronto', 'Canada', 'ACR_Mart', 'ACR Mart Toronto 4', 4, FALSE),
       (5, 'Dundas Street', 'Montreal', 'Canada', 'ACR_Mart', 'ACR Mart Montreal', 4, FALSE),
       (6, 'University Avenue', 'Toronto', 'Canada', 'ACR_Mart', 'ACR Mart Toronto 5', 4, FALSE),
       (7, 'Yonge Street', 'Toronto', 'Canada', 'ACR_Mart', 'ACR Mart Toronto 6', 3, FALSE),
       (8, 'Bloor Street', 'Toronto', 'Canada', 'ACR_Mart', 'ACR Mart Toronto 7', 5, FALSE);

-- Inserting phone numbers and emails for hotels under ACR_Mart (Toronto)

-- Inserting phone numbers and emails for ACR Mart Toronto 1
INSERT INTO Hotel_Phone (hotel_id, phone)
VALUES (1, 123456789);

INSERT INTO Hotel_Email (hotel_id, email)
VALUES (1, 'acrmarttoronto1@ACR_Mart.com');

-- Inserting phone numbers and emails for ACR Mart Toronto 2
INSERT INTO Hotel_Phone (hotel_id, phone)
VALUES (2, 234567890);

INSERT INTO Hotel_Email (hotel_id, email)
VALUES (2, 'acrm@ACR_Mart.com');

-- Inserting phone numbers and emails for ACR Mart Toronto 3
INSERT INTO Hotel_Phone (hotel_id, phone)
VALUES (3, 345678901);

INSERT INTO Hotel_Email (hotel_id, email)
VALUES (3, 'aco3@ACR_Mart.com');

-- Inserting phone numbers and emails for ACR Mart Toronto 4
INSERT INTO Hotel_Phone (hotel_id, phone)
VALUES (4, 456789012);

INSERT INTO Hotel_Email (hotel_id, email)
VALUES (4, 'acrmarttoronto4@ACR_Mart.com');

-- Inserting phone numbers and emails for ACR Mart Montreal
INSERT INTO Hotel_Phone (hotel_id, phone)
VALUES (5, 567890123);

INSERT INTO Hotel_Email (hotel_id, email)
VALUES (5, 'acrmart@ACR_Mart.com');

-- Inserting phone numbers and emails for ACR Mart Toronto 5
INSERT INTO Hotel_Phone (hotel_id, phone)
VALUES (6, 678901234);

INSERT INTO Hotel_Email (hotel_id, email)
VALUES (6, 'acrm@ACR_Mart.com');

-- Inserting phone numbers and emails for ACR Mart Toronto 6
INSERT INTO Hotel_Phone (hotel_id, phone)
VALUES (7, 789012345);

INSERT INTO Hotel_Email (hotel_id, email)
VALUES (7, 'acrmo6@ACR_Mart.com');

-- Inserting phone numbers and emails for ACR Mart Toronto 7
INSERT INTO Hotel_Phone (hotel_id, phone)
VALUES (8, 890123456);

INSERT INTO Hotel_Email (hotel_id, email)
VALUES (8, 'acrmartto7@ACR_Mart.com');


-- Inserting rooms for ACR Mart Toronto 1
INSERT INTO Room (hotel_id, price, capacity, extendable, room_number, archived)
VALUES (1, 150.00, 2, TRUE, 1, FALSE),
       (1, 150.00, 2, TRUE, 2, FALSE),
       (1, 200.00, 3, FALSE, 3, FALSE),
       (1, 200.00, 3, FALSE, 4, FALSE),
       (1, 250.00, 4, TRUE, 5, FALSE),
       (1, 250.00, 4, TRUE, 6, FALSE);

-- Inserting rooms for ACR Mart Toronto 2
INSERT INTO Room (hotel_id, price, capacity, extendable, room_number, archived)
VALUES (2, 180.00, 2, TRUE, 1, FALSE),
       (2, 180.00, 2, TRUE, 2, FALSE),
       (2, 220.00, 3, TRUE, 3, FALSE),
       (2, 220.00, 3, TRUE, 4, FALSE),
       (2, 270.00, 4, FALSE, 5, FALSE),
       (2, 270.00, 4, FALSE, 6, FALSE);

-- Inserting rooms for ACR Mart Toronto 3
INSERT INTO Room (hotel_id, price, capacity, extendable, room_number, archived)
VALUES (3, 200.00, 2, FALSE, 1, FALSE),
       (3, 200.00, 2, FALSE, 2, FALSE),
       (3, 250.00, 3, TRUE, 3, FALSE),
       (3, 250.00, 3, TRUE, 4, FALSE),
       (3, 300.00, 4, FALSE, 5, FALSE),
       (3, 300.00, 4, FALSE, 6, FALSE);

-- Inserting rooms for ACR Mart Toronto 4
INSERT INTO Room (hotel_id, price, capacity, extendable, room_number, archived)
VALUES (4, 170.00, 2, TRUE, 1, FALSE),
       (4, 170.00, 2, TRUE, 2, FALSE),
       (4, 210.00, 3, FALSE, 3, FALSE),
       (4, 210.00, 3, FALSE, 4, FALSE),
       (4, 260.00, 4, TRUE, 5, FALSE),
       (4, 260.00, 4, TRUE, 6, FALSE);

-- Inserting rooms for ACR Mart Montreal
INSERT INTO Room (hotel_id, price, capacity, extendable, room_number, archived)
VALUES (5, 150.00, 2, TRUE, 1, FALSE),
       (5, 150.00, 2, TRUE, 2, FALSE),
       (5, 200.00, 3, TRUE, 3, FALSE),
       (5, 200.00, 3, TRUE, 4, FALSE),
       (5, 250.00, 4, FALSE, 5, FALSE),
       (5, 250.00, 4, FALSE, 6, FALSE);

-- Inserting rooms for ACR Mart Toronto 5
INSERT INTO Room (hotel_id, price, capacity, extendable, room_number, archived)
VALUES (6, 160.00, 2, TRUE, 1, FALSE),
       (6, 160.00, 2, TRUE, 2, FALSE),
       (6, 210.00, 3, TRUE, 3, FALSE),
       (6, 210.00, 3, TRUE, 4, FALSE),
       (6, 260.00, 4, FALSE, 5, FALSE),
       (6, 260.00, 4, FALSE, 6, FALSE);

-- Inserting rooms for ACR Mart Toronto 6
INSERT INTO Room (hotel_id, price, capacity, extendable, room_number, archived)
VALUES (7, 170.00, 2, TRUE, 1, FALSE),
       (7, 170.00, 2, TRUE, 2, FALSE),
       (7, 220.00, 3, TRUE, 3, FALSE),
       (7, 220.00, 3, TRUE, 4, FALSE),
       (7, 270.00, 4, FALSE, 5, FALSE),
       (7, 270.00, 4, FALSE, 6, FALSE);

-- Inserting rooms for ACR Mart Toronto 7
INSERT INTO Room (hotel_id, price, capacity, extendable, room_number, archived)
VALUES (8, 180.00, 2, TRUE, 1, FALSE),
       (8, 180.00, 2, TRUE, 2, FALSE),
       (8, 230.00, 3, TRUE, 3, FALSE),
       (8, 230.00, 3, TRUE, 4, FALSE),
       (8, 280.00, 4, FALSE, 5, FALSE),
       (8, 280.00, 4, FALSE, 6, FALSE);


-- Inserting hotels for ACR_Honors (Vancouver)
INSERT INTO Hotel (street_number, street_name, city, country, chain_name, name, stars, archived)
VALUES (9, 'Main Street', 'Vancouver', 'Canada', 'ACR_Honors', 'ACR Honors 1', 4, FALSE),
       (10, 'Robson Street', 'Vancouver', 'Canada', 'ACR_Honors', 'ACR Honors  2', 3, FALSE),
       (11, 'Granville Street', 'Vancouver', 'Canada', 'ACR_Honors', 'ACR Honors 3', 5, FALSE),
       (12, 'Denman Street', 'Toronto', 'Canada', 'ACR_Honors', 'ACR Honorshh', 4, FALSE),
       (13, 'Burrard Street', 'Calgary', 'Canada', 'ACR_Honors', 'ACR Honors', 4, FALSE),
       (14, 'Hastings Street', 'Vancouver', 'Canada', 'ACR_Honors', 'ACR Honors 4', 4, FALSE),
       (15, 'Cambie Street', 'Vancouver', 'Canada', 'ACR_Honors', 'ACR Honors 5', 3, FALSE),
       (16, 'West Georgia Street', 'Vancouver', 'Canada', 'ACR_Honors', 'ACR Honors 6', 5, FALSE);

-- Inserting phone numbers and emails for hotels under ACR_Honors (Vancouver)

-- Inserting phone numbers and emails for ACR Honors Vancouver 1
INSERT INTO Hotel_Phone (hotel_id, phone)
VALUES (9, 1234567890);

INSERT INTO Hotel_Email (hotel_id, email)
VALUES (9, 'a1@ACR_s.com');

-- Inserting phone numbers and emails for ACR Honors Vancouver 2
INSERT INTO Hotel_Phone (hotel_id, phone)
VALUES (10, 1345678901);

INSERT INTO Hotel_Email (hotel_id, email)
VALUES (10, 'ac2@ACR_Honors.com');

-- Inserting phone numbers and emails for ACR Honors Vancouver 3
INSERT INTO Hotel_Phone (hotel_id, phone)
VALUES (11, 1456789012);

INSERT INTO Hotel_Email (hotel_id, email)
VALUES (11, 'ac@ACrs.com');

-- Inserting phone numbers and emails for ACR Honors Toronto
INSERT INTO Hotel_Phone (hotel_id, phone)
VALUES (12, 1567890123);

INSERT INTO Hotel_Email (hotel_id, email)
VALUES (12, 'a@ACs.com');

-- Inserting phone numbers and emails for ACR Honors Calgary
INSERT INTO Hotel_Phone (hotel_id, phone)
VALUES (13, 1678901234);

INSERT INTO Hotel_Email (hotel_id, email)
VALUES (13, 'ay@Aors.com');

-- Inserting phone numbers and emails for ACR Honors Vancouver 4
INSERT INTO Hotel_Phone (hotel_id, phone)
VALUES (14, 1789012345);

INSERT INTO Hotel_Email (hotel_id, email)
VALUES (14, 'acrsv4@Ars.com');

-- Inserting phone numbers and emails for ACR Honors Vancouver 5
INSERT INTO Hotel_Phone (hotel_id, phone)
VALUES (15, 1890123456);

INSERT INTO Hotel_Email (hotel_id, email)
VALUES (15, 'acrv5@Aors.com');

-- Inserting phone numbers and emails for ACR Honors Vancouver 6
INSERT INTO Hotel_Phone (hotel_id, phone)
VALUES (16, 1901234567);

INSERT INTO Hotel_Email (hotel_id, email)
VALUES (16, 'acrho@ACrs.com');


-- Inserting rooms for ACR Honors Vancouver 1
INSERT INTO Room (hotel_id, price, capacity, extendable, room_number, archived)
VALUES (9, 150.00, 2, TRUE, 1, FALSE),
       (9, 150.00, 2, TRUE, 2, FALSE),
       (9, 200.00, 3, TRUE, 3, FALSE),
       (9, 200.00, 3, TRUE, 4, FALSE),
       (9, 250.00, 4, FALSE, 5, FALSE),
       (9, 250.00, 4, FALSE, 6, FALSE);

-- Inserting rooms for ACR Honors Vancouver 2
INSERT INTO Room (hotel_id, price, capacity, extendable, room_number, archived)
VALUES (10, 160.00, 2, TRUE, 1, FALSE),
       (10, 160.00, 2, TRUE, 2, FALSE),
       (10, 210.00, 3, TRUE, 3, FALSE),
       (10, 210.00, 3, TRUE, 4, FALSE),
       (10, 260.00, 4, FALSE, 5, FALSE),
       (10, 260.00, 4, FALSE, 6, FALSE);

-- Inserting rooms for ACR Honors Vancouver 3
INSERT INTO Room (hotel_id, price, capacity, extendable, room_number, archived)
VALUES (11, 170.00, 2, TRUE, 1, FALSE),
       (11, 170.00, 2, TRUE, 2, FALSE),
       (11, 220.00, 3, TRUE, 3, FALSE),
       (11, 220.00, 3, TRUE, 4, FALSE),
       (11, 270.00, 4, FALSE, 5, FALSE),
       (11, 270.00, 4, FALSE, 6, FALSE);

-- Inserting rooms for ACR Honors Toronto
INSERT INTO Room (hotel_id, price, capacity, extendable, room_number, archived)
VALUES (12, 160.00, 2, TRUE, 1, FALSE),
       (12, 160.00, 2, TRUE, 2, FALSE),
       (12, 210.00, 3, TRUE, 3, FALSE),
       (12, 210.00, 3, TRUE, 4, FALSE),
       (12, 260.00, 4, FALSE, 5, FALSE),
       (12, 260.00, 4, FALSE, 6, FALSE);

-- Inserting rooms for ACR Honors Calgary
INSERT INTO Room (hotel_id, price, capacity, extendable, room_number, archived)
VALUES (13, 180.00, 2, TRUE, 1, FALSE),
       (13, 180.00, 2, TRUE, 2, FALSE),
       (13, 230.00, 3, TRUE, 3, FALSE),
       (13, 230.00, 3, TRUE, 4, FALSE),
       (13, 280.00, 4, FALSE, 5, FALSE),
       (13, 280.00, 4, FALSE, 6, FALSE);

-- Inserting rooms for ACR Honors Vancouver 4
INSERT INTO Room (hotel_id, price, capacity, extendable, room_number, archived)
VALUES (14, 180.00, 2, TRUE, 1, FALSE),
       (14, 180.00, 2, TRUE, 2, FALSE),
       (14, 230.00, 3, TRUE, 3, FALSE),
       (14, 230.00, 3, TRUE, 4, FALSE),
       (14, 280.00, 4, FALSE, 5, FALSE),
       (14, 280.00, 4, FALSE, 6, FALSE);

-- Inserting rooms for ACR Honors Vancouver 5
INSERT INTO Room (hotel_id, price, capacity, extendable, room_number, archived)
VALUES (15, 190.00, 2, TRUE, 1, FALSE),
       (15, 190.00, 2, TRUE, 2, FALSE),
       (15, 240.00, 3, TRUE, 3, FALSE),
       (15, 240.00, 3, TRUE, 4, FALSE),
       (15, 290.00, 4, FALSE, 5, FALSE),
       (15, 290.00, 4, FALSE, 6, FALSE);

-- Inserting rooms for ACR Honors Vancouver 6
INSERT INTO Room (hotel_id, price, capacity, extendable, room_number, archived)
VALUES (16, 200.00, 2, TRUE, 1, FALSE),
       (16, 200.00, 2, TRUE, 2, FALSE),
       (16, 250.00, 3, TRUE, 3, FALSE),
       (16, 250.00, 3, TRUE, 4, FALSE),
       (16, 300.00, 4, FALSE, 5, FALSE),
       (16, 300.00, 4, FALSE, 6, FALSE);


-- Inserting hotels for ACR_Suites (Montreal)
INSERT INTO Hotel (street_number, street_name, city, country, chain_name, name, stars, archived)
VALUES (17, 'Sainte-Catherine Street', 'Montreal', 'Canada', 'ACR_Suites', 'ACR Suites Montreal 1', 4, FALSE),
       (18, 'Rue Peel', 'Montreal', 'Canada', 'ACR_Suites', 'ACRSuitesMont2', 3, FALSE),
       (19, 'Sherbrooke Street', 'Montreal', 'Canada', 'ACR_Suites', 'ACRSuitesMont3', 5, FALSE),
       (20, 'Saint-Laurent Boulevard', 'Ottawa', 'Canada', 'ACR_Suites', 'ACRSuitesOtta', 4, FALSE),
       (21, 'Elgin Street', 'Halifax', 'Canada', 'ACR_Suites', 'ACRSuitesHal', 4, FALSE),
       (22, 'Rue de la Montagne', 'Montreal', 'Canada', 'ACR_Suites', 'ACRSuitesMon4', 4, FALSE),
       (23, 'Rue Saint-Paul', 'Montreal', 'Canada', 'ACR_Suites', 'ACRSuitesMont5', 3, FALSE),
       (24, 'Rue Sherbrooke', 'Montreal', 'Canada', 'ACR_Suites', 'ACRSuitesMon6', 5, FALSE);

-- Inserting phone numbers and emails for hotels under ACR_Suites (Montreal)

-- Inserting phone numbers and emails for ACR Suites Montreal 1
INSERT INTO Hotel_Phone (hotel_id, phone)
VALUES (17, 1234567890);

INSERT INTO Hotel_Email (hotel_id, email)
VALUES (17, 'acrsuitesmontreal1@ACR_Suites.com');

-- Inserting phone numbers and emails for ACR Suites Montreal 2
INSERT INTO Hotel_Phone (hotel_id, phone)
VALUES (18, 1234567891);

INSERT INTO Hotel_Email (hotel_id, email)
VALUES (18, 'acrsuitesmontreal2@ACR_Suites.com');

-- Inserting phone numbers and emails for ACR Suites Montreal 3
INSERT INTO Hotel_Phone (hotel_id, phone)
VALUES (19, 1234567892);

INSERT INTO Hotel_Email (hotel_id, email)
VALUES (19, 'acrsuitesmontreal3@ACR_Suites.com');

-- Inserting phone numbers and emails for ACR Suites Ottawa
INSERT INTO Hotel_Phone (hotel_id, phone)
VALUES (20, 1234567893);

INSERT INTO Hotel_Email (hotel_id, email)
VALUES (20, 'acrsuitesottawa@ACR_Suites.com');

-- Inserting phone numbers and emails for ACR Suites Halifax
INSERT INTO Hotel_Phone (hotel_id, phone)
VALUES (21, 1234567894);

INSERT INTO Hotel_Email (hotel_id, email)
VALUES (21, 'acrsuiteshalifax@ACR_Suites.com');

-- Inserting phone numbers and emails for ACR Suites Montreal 4
INSERT INTO Hotel_Phone (hotel_id, phone)
VALUES (22, 1234567895);

INSERT INTO Hotel_Email (hotel_id, email)
VALUES (22, 'acrsuitesmontreal4@ACR_Suites.com');

-- Inserting phone numbers and emails for ACR Suites Montreal 5
INSERT INTO Hotel_Phone (hotel_id, phone)
VALUES (23, 1234567896);

INSERT INTO Hotel_Email (hotel_id, email)
VALUES (23, 'acrsuitesmontreal5@ACR_Suites.com');

-- Inserting phone numbers and emails for ACR Suites Montreal 6
INSERT INTO Hotel_Phone (hotel_id, phone)
VALUES (24, 1234567897);

INSERT INTO Hotel_Email (hotel_id, email)
VALUES (24, 'acrsuitesmontreal6@ACR_Suites.com');

-- Inserting rooms for ACR Suites Montreal 1
INSERT INTO Room (hotel_id, price, capacity, extendable, room_number, archived)
VALUES (17, 150.00, 2, TRUE, 1, FALSE),
       (17, 150.00, 2, TRUE, 2, FALSE),
       (17, 200.00, 3, TRUE, 3, FALSE),
       (17, 200.00, 3, TRUE, 4, FALSE),
       (17, 250.00, 4, FALSE, 5, FALSE),
       (17, 250.00, 4, FALSE, 6, FALSE);

-- Inserting rooms for ACR Suites Montreal 2
INSERT INTO Room (hotel_id, price, capacity, extendable, room_number, archived)
VALUES (18, 160.00, 2, TRUE, 1, FALSE),
       (18, 160.00, 2, TRUE, 2, FALSE),
       (18, 210.00, 3, TRUE, 3, FALSE),
       (18, 210.00, 3, TRUE, 4, FALSE),
       (18, 260.00, 4, FALSE, 5, FALSE),
       (18, 260.00, 4, FALSE, 6, FALSE);

-- Inserting rooms for ACR Suites Montreal 3
INSERT INTO Room (hotel_id, price, capacity, extendable, room_number, archived)
VALUES (19, 170.00, 2, TRUE, 1, FALSE),
       (19, 170.00, 2, TRUE, 2, FALSE),
       (19, 220.00, 3, TRUE, 3, FALSE),
       (19, 220.00, 3, TRUE, 4, FALSE),
       (19, 270.00, 4, FALSE, 5, FALSE),
       (19, 270.00, 4, FALSE, 6, FALSE);

-- Inserting rooms for ACR Suites Ottawa
INSERT INTO Room (hotel_id, price, capacity, extendable, room_number, archived)
VALUES (20, 180.00, 2, TRUE, 1, FALSE),
       (20, 180.00, 2, TRUE, 2, FALSE),
       (20, 230.00, 3, TRUE, 3, FALSE),
       (20, 230.00, 3, TRUE, 4, FALSE),
       (20, 280.00, 4, FALSE, 5, FALSE),
       (20, 280.00, 4, FALSE, 6, FALSE);

-- Inserting rooms for ACR Suites Halifax
INSERT INTO Room (hotel_id, price, capacity, extendable, room_number, archived)
VALUES (21, 190.00, 2, TRUE, 1, FALSE),
       (21, 190.00, 2, TRUE, 2, FALSE),
       (21, 240.00, 3, TRUE, 3, FALSE),
       (21, 240.00, 3, TRUE, 4, FALSE),
       (21, 290.00, 4, FALSE, 5, FALSE),
       (21, 290.00, 4, FALSE, 6, FALSE);

-- Inserting rooms for ACR Suites Montreal 4
INSERT INTO Room (hotel_id, price, capacity, extendable, room_number, archived)
VALUES (22, 200.00, 2, TRUE, 1, FALSE),
       (22, 200.00, 2, TRUE, 2, FALSE),
       (22, 250.00, 3, TRUE, 3, FALSE),
       (22, 250.00, 3, TRUE, 4, FALSE),
       (22, 300.00, 4, FALSE, 5, FALSE),
       (22, 300.00, 4, FALSE, 6, FALSE);

-- Inserting rooms for ACR Suites Montreal 5
INSERT INTO Room (hotel_id, price, capacity, extendable, room_number, archived)
VALUES (23, 210.00, 2, TRUE, 1, FALSE),
       (23, 210.00, 2, TRUE, 2, FALSE),
       (23, 260.00, 3, TRUE, 3, FALSE),
       (23, 260.00, 3, TRUE, 4, FALSE),
       (23, 310.00, 4, FALSE, 5, FALSE),
       (23, 310.00, 4, FALSE, 6, FALSE);

-- Inserting rooms for ACR Suites Montreal 6
INSERT INTO Room (hotel_id, price, capacity, extendable, room_number, archived)
VALUES (24, 220.00, 2, TRUE, 1, FALSE),
       (24, 220.00, 2, TRUE, 2, FALSE),
       (24, 270.00, 3, TRUE, 3, FALSE),
       (24, 270.00, 3, TRUE, 4, FALSE),
       (24, 320.00, 4, FALSE, 5, FALSE),
       (24, 320.00, 4, FALSE, 6, FALSE);


-- Inserting hotels for ACR_Camp (Winnipeg)
INSERT INTO Hotel (street_number, street_name, city, country, chain_name, name, stars, archived)
VALUES (25, 'Portage Avenue', 'Winnipeg', 'Canada', 'ACR_Camp', 'ACR Camp Winnipeg 1', 4, FALSE),
       (26, 'Main Street', 'Winnipeg', 'Canada', 'ACR_Camp', 'ACR Camp Winnipeg 2', 3, FALSE),
       (27, 'Assiniboine Avenue', 'Winnipeg', 'Canada', 'ACR_Camp', 'ACR Camp Winnipeg 3', 5, FALSE),
       (28, 'Pembina Highway', 'Toronto', 'Canada', 'ACR_Camp', 'ACR Camp Toronto', 4, FALSE),
       (29, 'Regent Avenue', 'Halifax', 'Canada', 'ACR_Camp', 'ACR Camp Halifax', 4, FALSE),
       (30, 'Main Street', 'Winnipeg', 'Canada', 'ACR_Camp', 'ACR Camp Winnipeg 4', 4, FALSE),
       (31, 'Pembina Highway', 'Winnipeg', 'Canada', 'ACR_Camp', 'ACR Camp Winnipeg 5', 3, FALSE),
       (32, 'St. Mary Avenue', 'Winnipeg', 'Canada', 'ACR_Camp', 'ACR Camp Winnipeg 6', 5, FALSE);

-- Inserting phone numbers and emails for hotels under ACR_Camp (Winnipeg)

-- Inserting phone numbers and emails for ACR Camp Winnipeg 1
INSERT INTO Hotel_Phone (hotel_id, phone)
VALUES (25, 1234567890);

INSERT INTO Hotel_Email (hotel_id, email)
VALUES (25, 'acrcampwinnipeg1@ACR_Camp.com');

-- Inserting phone numbers and emails for ACR Camp Winnipeg 2
INSERT INTO Hotel_Phone (hotel_id, phone)
VALUES (26, 1234567891);

INSERT INTO Hotel_Email (hotel_id, email)
VALUES (26, 'acrcampwinnipeg2@ACR_Camp.com');

-- Inserting phone numbers and emails for ACR Camp Winnipeg 3
INSERT INTO Hotel_Phone (hotel_id, phone)
VALUES (27, 1234567892);

INSERT INTO Hotel_Email (hotel_id, email)
VALUES (27, 'acrcampwinnipeg3@ACR_Camp.com');

-- Inserting phone numbers and emails for ACR Camp Toronto
INSERT INTO Hotel_Phone (hotel_id, phone)
VALUES (28, 1234567893);

INSERT INTO Hotel_Email (hotel_id, email)
VALUES (28, 'acrcamptoronto@ACR_Camp.com');

-- Inserting phone numbers and emails for ACR Camp Halifax
INSERT INTO Hotel_Phone (hotel_id, phone)
VALUES (29, 1234567894);

INSERT INTO Hotel_Email (hotel_id, email)
VALUES (29, 'acrcamphalifax@ACR_Camp.com');

-- Inserting phone numbers and emails for ACR Camp Winnipeg 4
INSERT INTO Hotel_Phone (hotel_id, phone)
VALUES (30, 1234567895);

INSERT INTO Hotel_Email (hotel_id, email)
VALUES (30, 'acrcampwinnipeg4@ACR_Camp.com');

-- Inserting phone numbers and emails for ACR Camp Winnipeg 5
INSERT INTO Hotel_Phone (hotel_id, phone)
VALUES (31, 1234567896);

INSERT INTO Hotel_Email (hotel_id, email)
VALUES (31, 'acrcampwinnipeg5@ACR_Camp.com');

-- Inserting phone numbers and emails for ACR Camp Winnipeg 6
INSERT INTO Hotel_Phone (hotel_id, phone)
VALUES (32, 1234567897);

INSERT INTO Hotel_Email (hotel_id, email)
VALUES (32, 'acrcampwinnipeg6@ACR_Camp.com');

-- Inserting rooms for ACR Camp Winnipeg 1
INSERT INTO Room (hotel_id, price, capacity, extendable, room_number, archived)
VALUES (25, 150.00, 2, TRUE, 1, FALSE),
       (25, 150.00, 2, TRUE, 2, FALSE),
       (25, 200.00, 3, TRUE, 3, FALSE),
       (25, 200.00, 3, TRUE, 4, FALSE),
       (25, 250.00, 4, FALSE, 5, FALSE),
       (25, 250.00, 4, FALSE, 6, FALSE);

-- Inserting rooms for ACR Camp Winnipeg 2
INSERT INTO Room (hotel_id, price, capacity, extendable, room_number, archived)
VALUES (26, 160.00, 2, TRUE, 1, FALSE),
       (26, 160.00, 2, TRUE, 2, FALSE),
       (26, 210.00, 3, TRUE, 3, FALSE),
       (26, 210.00, 3, TRUE, 4, FALSE),
       (26, 260.00, 4, FALSE, 5, FALSE),
       (26, 260.00, 4, FALSE, 6, FALSE);

-- Inserting rooms for ACR Camp Winnipeg 3
INSERT INTO Room (hotel_id, price, capacity, extendable, room_number, archived)
VALUES (27, 170.00, 2, TRUE, 1, FALSE),
       (27, 170.00, 2, TRUE, 2, FALSE),
       (27, 220.00, 3, TRUE, 3, FALSE),
       (27, 220.00, 3, TRUE, 4, FALSE),
       (27, 270.00, 4, FALSE, 5, FALSE),
       (27, 270.00, 4, FALSE, 6, FALSE);

-- Inserting rooms for ACR Camp Toronto
INSERT INTO Room (hotel_id, price, capacity, extendable, room_number, archived)
VALUES (28, 160.00, 2, TRUE, 1, FALSE),
       (28, 160.00, 2, TRUE, 2, FALSE),
       (28, 210.00, 3, TRUE, 3, FALSE),
       (28, 210.00, 3, TRUE, 4, FALSE),
       (28, 260.00, 4, FALSE, 5, FALSE),
       (28, 260.00, 4, FALSE, 6, FALSE);

-- Inserting rooms for ACR Camp Halifax
INSERT INTO Room (hotel_id, price, capacity, extendable, room_number, archived)
VALUES (29, 170.00, 2, TRUE, 1, FALSE),
       (29, 170.00, 2, TRUE, 2, FALSE),
       (29, 220.00, 3, TRUE, 3, FALSE),
       (29, 220.00, 3, TRUE, 4, FALSE),
       (29, 270.00, 4, FALSE, 5, FALSE),
       (29, 270.00, 4, FALSE, 6, FALSE);

-- Inserting rooms for ACR Camp Winnipeg 4
INSERT INTO Room (hotel_id, price, capacity, extendable, room_number, archived)
VALUES (30, 180.00, 2, TRUE, 1, FALSE),
       (30, 180.00, 2, TRUE, 2, FALSE),
       (30, 230.00, 3, TRUE, 3, FALSE),
       (30, 230.00, 3, TRUE, 4, FALSE),
       (30, 280.00, 4, FALSE, 5, FALSE),
       (30, 280.00, 4, FALSE, 6, FALSE);

-- Inserting rooms for ACR Camp Winnipeg 5
INSERT INTO Room (hotel_id, price, capacity, extendable, room_number, archived)
VALUES (31, 190.00, 2, TRUE, 1, FALSE),
       (31, 190.00, 2, TRUE, 2, FALSE),
       (31, 240.00, 3, TRUE, 3, FALSE),
       (31, 240.00, 3, TRUE, 4, FALSE),
       (31, 290.00, 4, FALSE, 5, FALSE),
       (31, 290.00, 4, FALSE, 6, FALSE);

-- Inserting rooms for ACR Camp Winnipeg 6
INSERT INTO Room (hotel_id, price, capacity, extendable, room_number, archived)
VALUES (32, 200.00, 2, TRUE, 1, FALSE),
       (32, 200.00, 2, TRUE, 2, FALSE),
       (32, 250.00, 3, TRUE, 3, FALSE),
       (32, 250.00, 3, TRUE, 4, FALSE),
       (32, 300.00, 4, FALSE, 5, FALSE),
       (32, 300.00, 4, FALSE, 6, FALSE);


-- Inserting hotels for ACR_Lodge (Calgary)
INSERT INTO Hotel (street_number, street_name, city, country, chain_name, name, stars, archived)
VALUES (33, 'Granville Street', 'Calgary', 'Canada', 'ACR_Lodge', 'ACR Lodge Calgary 1', 4, FALSE),
       (34, '17th Avenue SW', 'Calgary', 'Canada', 'ACR_Lodge', 'ACR Lodge Calgary 2', 3, FALSE),
       (35, 'Bow Trail SW', 'Calgary', 'Canada', 'ACR_Lodge', 'ACR Lodge Calgary 3', 5, FALSE),
       (36, 'Sarcee Trail NW', 'Toronto', 'Canada', 'ACR_Lodge', 'ACR Lodge Toronto', 4, FALSE),
       (37, 'Crowchild Trail NW', 'Halifax', 'Canada', 'ACR_Lodge', 'ACR Lodge Halifax', 4, FALSE),
       (38, '4th Avenue SW', 'Calgary', 'Canada', 'ACR_Lodge', 'ACR Lodge Calgary 4', 4, FALSE),
       (39, 'Centre Street', 'Calgary', 'Canada', 'ACR_Lodge', 'ACR Lodge Calgary 5', 3, FALSE),
       (40, 'MacLeod Trail SE', 'Calgary', 'Canada', 'ACR_Lodge', 'ACR Lodge Calgary 6', 5, FALSE);

-- Inserting phone numbers and emails for hotels under ACR_Lodge (Calgary)

-- Inserting phone numbers and emails for ACR Lodge Calgary 1
INSERT INTO Hotel_Phone (hotel_id, phone)
VALUES (33, 1234567890);

INSERT INTO Hotel_Email (hotel_id, email)
VALUES (33, 'acrlodgecalgary1@ACR_Lodge.com');

-- Inserting phone numbers and emails for ACR Lodge Calgary 2
INSERT INTO Hotel_Phone (hotel_id, phone)
VALUES (34, 1234567891);

INSERT INTO Hotel_Email (hotel_id, email)
VALUES (34, 'acrlodgecalgary2@ACR_Lodge.com');

-- Inserting phone numbers and emails for ACR Lodge Calgary 3
INSERT INTO Hotel_Phone (hotel_id, phone)
VALUES (35, 1234567892);

INSERT INTO Hotel_Email (hotel_id, email)
VALUES (35, 'acrlodgecalgary3@ACR_Lodge.com');

-- Inserting phone numbers and emails for ACR Lodge Toronto
INSERT INTO Hotel_Phone (hotel_id, phone)
VALUES (36, 1234567893);

INSERT INTO Hotel_Email (hotel_id, email)
VALUES (36, 'acrlodgetoronto@ACR_Lodge.com');

-- Inserting phone numbers and emails for ACR Lodge Halifax
INSERT INTO Hotel_Phone (hotel_id, phone)
VALUES (37, 1234567894);

INSERT INTO Hotel_Email (hotel_id, email)
VALUES (37, 'acrlodgehalifax@ACR_Lodge.com');

-- Inserting phone numbers and emails for ACR Lodge Calgary 4
INSERT INTO Hotel_Phone (hotel_id, phone)
VALUES (38, 1234567895);

INSERT INTO Hotel_Email (hotel_id, email)
VALUES (38, 'acrlodgecalgary4@ACR_Lodge.com');

-- Inserting phone numbers and emails for ACR Lodge Calgary 5
INSERT INTO Hotel_Phone (hotel_id, phone)
VALUES (39, 1234567896);

INSERT INTO Hotel_Email (hotel_id, email)
VALUES (39, 'acrlodgecalgary5@ACR_Lodge.com');

-- Inserting phone numbers and emails for ACR Lodge Calgary 6
INSERT INTO Hotel_Phone (hotel_id, phone)
VALUES (40, 1234567897);

INSERT INTO Hotel_Email (hotel_id, email)
VALUES (40, 'acrlodgecalgary6@ACR_Lodge.com');

-- Inserting rooms for ACR Lodge Calgary 1
INSERT INTO Room (hotel_id, price, capacity, extendable, room_number, archived)
VALUES (33, 150.00, 2, TRUE, 1, FALSE),
       (33, 150.00, 2, TRUE, 2, FALSE),
       (33, 200.00, 3, TRUE, 3, FALSE),
       (33, 200.00, 3, TRUE, 4, FALSE),
       (33, 250.00, 4, FALSE, 5, FALSE),
       (33, 250.00, 4, FALSE, 6, FALSE);

-- Inserting rooms for ACR Lodge Calgary 2
INSERT INTO Room (hotel_id, price, capacity, extendable, room_number, archived)
VALUES (34, 160.00, 2, TRUE, 1, FALSE),
       (34, 160.00, 2, TRUE, 2, FALSE),
       (34, 210.00, 3, TRUE, 3, FALSE),
       (34, 210.00, 3, TRUE, 4, FALSE),
       (34, 260.00, 4, FALSE, 5, FALSE),
       (34, 260.00, 4, FALSE, 6, FALSE);

-- Inserting rooms for ACR Lodge Calgary 3
INSERT INTO Room (hotel_id, price, capacity, extendable, room_number, archived)
VALUES (35, 170.00, 2, TRUE, 1, FALSE),
       (35, 170.00, 2, TRUE, 2, FALSE),
       (35, 220.00, 3, TRUE, 3, FALSE),
       (35, 220.00, 3, TRUE, 4, FALSE),
       (35, 270.00, 4, FALSE, 5, FALSE),
       (35, 270.00, 4, FALSE, 6, FALSE);

-- Inserting rooms for ACR Lodge Toronto
INSERT INTO Room (hotel_id, price, capacity, extendable, room_number, archived)
VALUES (36, 160.00, 2, TRUE, 1, FALSE),
       (36, 160.00, 2, TRUE, 2, FALSE),
       (36, 210.00, 3, TRUE, 3, FALSE),
       (36, 210.00, 3, TRUE, 4, FALSE),
       (36, 260.00, 4, FALSE, 5, FALSE),
       (36, 260.00, 4, FALSE, 6, FALSE);

-- Inserting rooms for ACR Lodge Halifax
INSERT INTO Room (hotel_id, price, capacity, extendable, room_number, archived)
VALUES (37, 170.00, 2, TRUE, 1, FALSE),
       (37, 170.00, 2, TRUE, 2, FALSE),
       (37, 220.00, 3, TRUE, 3, FALSE),
       (37, 220.00, 3, TRUE, 4, FALSE),
       (37, 270.00, 4, FALSE, 5, FALSE),
       (37, 270.00, 4, FALSE, 6, FALSE);

-- Inserting rooms for ACR Lodge Calgary 4
INSERT INTO Room (hotel_id, price, capacity, extendable, room_number, archived)
VALUES (38, 180.00, 2, TRUE, 1, FALSE),
       (38, 180.00, 2, TRUE, 2, FALSE),
       (38, 230.00, 3, TRUE, 3, FALSE),
       (38, 230.00, 3, TRUE, 4, FALSE),
       (38, 280.00, 4, FALSE, 5, FALSE),
       (38, 280.00, 4, FALSE, 6, FALSE);

-- Inserting rooms for ACR Lodge Calgary 5
INSERT INTO Room (hotel_id, price, capacity, extendable, room_number, archived)
VALUES (39, 190.00, 2, TRUE, 1, FALSE),
       (39, 190.00, 2, TRUE, 2, FALSE),
       (39, 240.00, 3, TRUE, 3, FALSE),
       (39, 240.00, 3, TRUE, 4, FALSE),
       (39, 290.00, 4, FALSE, 5, FALSE),
       (39, 290.00, 4, FALSE, 6, FALSE);

-- Inserting rooms for ACR Lodge Calgary 6
INSERT INTO Room (hotel_id, price, capacity, extendable, room_number, archived)
VALUES (40, 200.00, 2, TRUE, 1, FALSE),
       (40, 200.00, 2, TRUE, 2, FALSE),
       (40, 250.00, 3, TRUE, 3, FALSE),
       (40, 250.00, 3, TRUE, 4, FALSE),
       (40, 300.00, 4, FALSE, 5, FALSE),
       (40, 300.00, 4, FALSE, 6, FALSE);

INSERT INTO Customer
VALUES
    (123, 'Alex', 'Ajersch', 110, 'Havelock', 'Ottawa', 'Canada', '2020-04-02'),
    (124, 'John', 'Doe', 111, 'Main Street', 'Toronto', 'Canada', '2020-05-03'),
    (125, 'Jane', 'Smith', 112, 'King Street', 'Vancouver', 'Canada', '2020-06-04'),
    (126, 'Bob', 'Johnson', 113, 'Queen Street', 'Montreal', 'Canada', '2020-07-05'),
    (127, 'Alice', 'Williams', 114, 'Yonge Street', 'Calgary', 'Canada', '2020-08-06'),
    (128, 'Charlie', 'Brown', 115, 'Bloor Street', 'Edmonton', 'Canada', '2020-09-07');

INSERT INTO Employee
VALUES (321, 'Alex', 'Andrus', 110, 'Havelock', 'Ottawa', 'Canada');
INSERT INTO Employee
VALUES
    (322, 'Robert', 'Brown', 111, 'Main Street', 'Toronto', 'Canada'),
    (323, 'Emily', 'Clark', 112, 'King Street', 'Vancouver', 'Canada'),
    (324, 'Oliver', 'Johnson', 113, 'Queen Street', 'Montreal', 'Canada'),
    (325, 'Sophia', 'Williams', 114, 'Yonge Street', 'Calgary', 'Canada'),
    (326, 'Liam', 'Davis', 115, 'Bloor Street', 'Edmonton', 'Canada');

INSERT INTO Booking
VALUES (1, '2024-03-28', '2024-04-28', 123),
       (2, '2024-03-28', '2024-04-28', 123),
       (3, '2024-03-28', '2024-04-28', 123);

INSERT INTO Booking
VALUES
    (7, '2024-04-01', '2024-04-30', 124),
    (8, '2024-05-01', '2024-05-31', 125),
    (4, '2024-06-01', '2024-06-30', 126),
    (5, '2024-07-01', '2024-07-31', 127),
    (6, '2024-08-01', '2024-08-31', 128);

