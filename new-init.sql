SET SEARCH_PATH = "Hotel";

CREATE TABLE Chain (
    street_number int,
	street varchar(20),
	city varchar(20),
	province varchar(20),
	country varchar(20),
    name varchar(20) NOT NULL,
    archived boolean DEFAULT FALSE,
    PRIMARY KEY (name)
);

CREATE TABLE Chain_Phone (
    chain_name varchar(20),
    phone int,
    PRIMARY KEY (chain_name, phone),
    FOREIGN KEY (chain_name) REFERENCES Chain(name)
);

CREATE TABLE Chain_Email (
    chain_name varchar(20),
    email varchar(40),
    PRIMARY KEY (chain_name, email),
    FOREIGN KEY (chain_name) REFERENCES Chain(name)
);

CREATE TABLE Hotel (
    street_number int,
	street varchar(20),
	city varchar(20),
	province varchar(20),
	country varchar(20),
    chain_name varchar(20),
    name varchar(20),
    stars int,
    archived boolean DEFAULT FALSE,
    PRIMARY KEY (street_number,street,city,province,country),
    FOREIGN KEY (chain_name) REFERENCES Chain(name)
);

CREATE TABLE Hotel_Phone (
    hotel_street_number int,
	hotel_street varchar(20),
	hotel_city varchar(20),
	hotel_province varchar(20),
	hotel_country varchar(20),
    phone int,
    PRIMARY KEY (hotel_street_number,hotel_street,hotel_city,hotel_province,hotel_country, phone),
    FOREIGN KEY (hotel_street_number,hotel_street,hotel_city,hotel_province,hotel_country) REFERENCES Hotel(street_number, street, city, province, country)
);

CREATE TABLE Hotel_Email (
    hotel_street_number int,
	hotel_street varchar(20),
	hotel_city varchar(20),
	hotel_province varchar(20),
	hotel_country varchar(20),
    email varchar(40),
    PRIMARY KEY (hotel_street_number,hotel_street,hotel_city,hotel_province,hotel_country, email),
    FOREIGN KEY (hotel_street_number,hotel_street,hotel_city,hotel_province,hotel_country) REFERENCES Hotel(street_number, street, city, province, country)
);

CREATE TABLE Room (
    room_id int,
    hotel_street_number int,
	hotel_street varchar(20),
	hotel_city varchar(20),
	hotel_province varchar(20),
	hotel_country varchar(20),
    price float,
    capacity int,
    extendable boolean,
    room_number int,
    archived boolean DEFAULT FALSE,
    PRIMARY KEY (room_id)
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
    first_name varchar(20),
    last_name varchar(20),
    address varchar(20),
    registration_date date,
    archived boolean DEFAULT FALSE,
    PRIMARY KEY (sin)
);

CREATE TABLE Employee (
    sin int,
    first_name varchar(20),
    last_name varchar(20),
    address varchar(20),
    archived boolean DEFAULT FALSE,
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
    hotel_street_number int,
	hotel_street varchar(20),
	hotel_city varchar(20),
	hotel_province varchar(20),
	hotel_country varchar(20),
    employee_sin int,
    PRIMARY KEY (hotel_street_number,hotel_street,hotel_city,hotel_province,hotel_country, employee_sin),
    FOREIGN KEY (hotel_street_number,hotel_street,hotel_city,hotel_province,hotel_country) REFERENCES Hotel(street_number,street,city,province,country),
    FOREIGN KEY (employee_sin) REFERENCES Employee(sin)
);

CREATE TABLE Booking (
    room_id int,
    start_date date,
    end_date date,
    customer_sin int,
    PRIMARY KEY (room_id, start_date),
    FOREIGN KEY (room_id) REFERENCES Room(room_id),
    FOREIGN KEY (customer_sin) REFERENCES Customer(sin)
);

CREATE TABLE Booking_Archive (
    room_id int,
    start_date date,
    end_date date,
    customer_sin int,
    PRIMARY KEY (room_id, start_date),
    FOREIGN KEY (room_id) REFERENCES Room(room_id),
    FOREIGN KEY (customer_sin) REFERENCES Customer(sin)
);

CREATE TABLE Checks_In (
    room_id int,
    start_date date,
    employee_sin int,
    PRIMARY KEY (room_id, start_date),
    FOREIGN KEY (room_id, start_date) REFERENCES Booking(room_id, start_date),
    FOREIGN KEY (employee_sin) REFERENCES Employee(sin)
);

CREATE TABLE Checks_In_Archive (
    room_id int,
    start_date date,
    employee_sin int,
    PRIMARY KEY (room_id, start_date),
    FOREIGN KEY (room_id, start_date) REFERENCES Booking_Archive(room_id, start_date),
    FOREIGN KEY (employee_sin) REFERENCES Employee(sin)
);