CREATE TABLE Chain (
    street_number int NOT NULL,
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
    email varchar(100),
    PRIMARY KEY (chain_name, email),
    FOREIGN KEY (chain_name) REFERENCES Chain(name)
);

CREATE TABLE Hotel (
    id SERIAL,
    street_number int NOT NULL,
	street_name varchar(20) NOT NULL,
	city varchar(20) NOT NULL,
	country varchar(20) NOT NULL,
    chain_name varchar(100),
    name varchar(100) NOT NULL,
    stars int NOT NULL,
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
    email varchar(100),
    PRIMARY KEY (hotel_id, email),
    FOREIGN KEY (hotel_id) REFERENCES Hotel(id)
);

CREATE TABLE Room (
    room_id SERIAL,
    hotel_id int NOT NULL,
    price float NOT NULL,
    capacity int NOT NULL,
    extendable boolean NOT NULL,
    room_number int NOT NULL,
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
    registration_date date NOT NULL,
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
    end_date date NOT NULL,
    customer_sin int NOT NULL,
    PRIMARY KEY (room_id, start_date),
    FOREIGN KEY (room_id) REFERENCES Room(room_id),
    FOREIGN KEY (customer_sin) REFERENCES Customer(sin)
);

CREATE TABLE Booking_Archive (
    room_id int,
    start_date date,
    end_date date NOT NULL,
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
    FOREIGN KEY (room_id, start_date) REFERENCES Booking(room_id, start_date),
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