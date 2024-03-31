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