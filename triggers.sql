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

CREATE OR REPLACE FUNCTION booking_archiver() RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO Booking_Archive VALUES (NEW.room_id, NEW.start_date, NEW.end_date, NEW.customer_sin);
    RETURN NEW;
end;
$$ language plpgsql;

CREATE TRIGGER booking_archiver
    AFTER INSERT ON Booking
    FOR EACH STATEMENT
EXECUTE FUNCTION booking_archiver();


CREATE OR REPLACE FUNCTION check_in_archiver() RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO Checks_In_Archive VALUES (NEW.room_id, NEW.start_date, NEW.employee_sin);
    RETURN NEW;
end;
$$ language plpgsql;

CREATE TRIGGER check_in_archiver
    AFTER INSERT ON Checks_In
    FOR EACH STATEMENT
EXECUTE FUNCTION check_in_archiver();