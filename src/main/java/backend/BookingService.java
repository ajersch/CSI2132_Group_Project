package backend;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class BookingService {

    // Chelsea I'm only commenting one of these for you because
    // they are literally all exactly the same
    // and none of the comments will be useful to you
    // except for the first one

    /**
     * Gets a list of all bookings for a specified customer
     * @param customerSin the sin of the customer
     * @return a list of all bookings for the customer
     */
    public List<Booking> getCustomerBookings(int customerSin) {
        //make an empty list of bookings to begin
        List<Booking> bookings = new ArrayList<>();

        //try catch block in case we can't connect to the server
        try {
            //use the DBConnection class to get a connection to the database
            DBConnection dbConnection = new DBConnection();
            Connection con = dbConnection.getConnection();

            //make the sql statement with ? for values that get replaced by variables
            String sql = "SELECT * FROM booking " +
                         "WHERE customer_sin = ?;";

            //prepared statement is what we use to execute it
            PreparedStatement ps = con.prepareStatement(sql);

            //set the values of the ? in the sql statement to our variables
            ps.setInt(1, customerSin);

            //result set is the result of the query
            ResultSet rs = ps.executeQuery();

            //iterate through results and make bookings out of them
            //add the bookings to the return list
            while (rs.next()) {
                Booking booking = new Booking(
                        rs.getInt("room_id"),
                        rs.getString("start_date"),
                        rs.getString("end_date"),
                        rs.getInt("customer_sin")
                );
                bookings.add(booking);
            }

            //close all the connections because we are done with them for this function
            rs.close();
            ps.close();
            dbConnection.close();
        } catch (Exception e) {
            System.out.println("Error getting customer bookings");
            e.printStackTrace();
        }
        return bookings;
    }

    public Booking getBooking(String startDate, int roomId) {
        Booking booking = null;
        try {
            DBConnection dbConnection = new DBConnection();
            Connection con = dbConnection.getConnection();

            String sql = "SELECT * FROM booking " +
                    "WHERE start_date = ? AND room_id = ?;";

            PreparedStatement ps = con.prepareStatement(sql);

            ps.setString(1, startDate);
            ps.setInt(2, roomId);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                booking = new Booking(
                        rs.getInt("room_id"),
                        rs.getString("start_date"),
                        rs.getString("end_date"),
                        rs.getInt("customer_sin")
                );
            }

            rs.close();
            ps.close();
            dbConnection.close();
        } catch (Exception e) {
            System.out.println("Error getting booking");
            e.printStackTrace();
        }

        return booking;
    }

    /**
     * Checks in a customer
     * @param roomId the id of the room being checked in
     * @param startDate the start date of the booking
     * @param employeeSin the sin of the employee doing the check in
     */
    public void checkIn(int roomId, String startDate, int employeeSin) {
        try {
            DBConnection dbConnection = new DBConnection();
            Connection con = dbConnection.getConnection();

            String sql = "INSERT INTO Checks_In " +
                         "VALUES (?, CAST(? AS DATE), ?);";

            PreparedStatement ps = con.prepareStatement(sql);

            ps.setInt(1, roomId);
            ps.setString(2, startDate);
            ps.setInt(3, employeeSin);

            ps.executeUpdate();

            ps.close();
            dbConnection.close();
        } catch (Exception e) {
            System.out.println("Error checking in");
            e.printStackTrace();
        }
    }

    /**
     * Returns a list of rooms that are available for booking
     * @param startDate not null start date of the booking
     * @param endDate not null end date of the booking
     * @param chainName name of the hotel chain
     * @param city city of the hotel
     * @param capacity capacity of the room
     * @param stars stars of the hotel
     * @param numRooms minimum number of rooms of the hotel
     * @param minPrice minimum price
     * @param maxPrice maximum price
     * @param extendable whether the room is extendable
     * @return a list of rooms that are available for booking with the given criteria
     */
    public List<Room> searchRooms(String startDate,
                                  String endDate,
                                  String chainName,
                                  String city,
                                  int capacity,
                                  int stars,
                                  int numRooms,
                                  float minPrice,
                                  float maxPrice,
                                  boolean extendable) {
        List<Room> rooms = new ArrayList<>();

        try {
            DBConnection dbConnection = new DBConnection();
            Connection con = dbConnection.getConnection();

            String sql = "SELECT Room.* FROM Room JOIN Hotel ON Room.hotel_id = Hotel.id JOIN Num_Rooms ON Num_Rooms.id = Hotel.id " +
                         "WHERE Room.archived = FALSE " +
                         "AND Room.room_id NOT IN " +
                            "(SELECT Booking.room_id FROM Booking " +
                            "WHERE Booking.start_date < CAST(? as date) AND Booking.end_date > CAST(? as date))";

            if (chainName != null) {
                sql += " AND Hotel.chain_name = ? ";
            }

            if (city != null) {
                sql += " AND Hotel.city = ? ";
            }

            if (capacity > 0) {
                sql += " AND Room.capacity >= ? ";
            }

            if (stars > 0) {
                sql += " AND Hotel.stars = ? ";
            }

            if (numRooms > 0) {
                sql += " AND Num_Rooms.hotel_rooms >= ? ";
            }

            if (minPrice > 0) {
                sql += " AND Room.price >= ? ";
            }

            if (maxPrice > 0) {
                sql += " AND Room.price <= ? ";
            }

            if (extendable) {
                sql += " AND Room.extendable = TRUE ";
            }

            sql += ";";

            PreparedStatement ps = con.prepareStatement(sql);


            ps.setString(1, endDate);
            ps.setString(2, startDate);

            int i = 3;

            if (chainName != null) {
                ps.setString(i, chainName);
                i++;
            }

            if (city != null) {
                ps.setString(i, city);
                i++;
            }

            if (capacity > 0) {
                ps.setInt(i, capacity);
                i++;
            }

            if (stars >= 0) {
                ps.setInt(i, stars);
                i++;
            }

            if (numRooms > 0) {
                ps.setInt(i, numRooms);
                i++;
            }

            if (minPrice > 0) {
                ps.setFloat(i, minPrice);
                i++;
            }

            if (maxPrice > 0) {
                ps.setFloat(i, maxPrice);
            }

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Room room = new Room(rs.getInt("room_id"),
                                     rs.getInt("hotel_id"),
                                     rs.getFloat("price"),
                                    rs.getInt("capacity"),
                                    rs.getBoolean("extendable"),
                                    rs.getInt("room_number"),
                                    rs.getBoolean("archived"));
                rooms.add(room);
            }

            rs.close();
            ps.close();
            dbConnection.close();
        } catch (Exception e) {
            System.out.println("Error searching rooms");
            e.printStackTrace();
        }

        return rooms;
    }

//    public void checkIn(Booking booking, int employeeSin) {
//        try {
//            DBConnection dbConnection = new DBConnection();
//            Connection con = dbConnection.getConnection();
//
//            String sql = "INSERT INTO Checks_In " +
//                         "VALUES (?, ?, ?);";
//
//            PreparedStatement ps = con.prepareStatement(sql);
//
//            ps.setInt(1, booking.getRoomId());
//            ps.setString(2, booking.getStartDate());
//            ps.setInt(3, employeeSin);
//
//            ps.executeUpdate();
//
//            ps.close();
//            dbConnection.close();
//        } catch (Exception e) {
//            System.out.println("Error checking in");
//            e.printStackTrace();
//        }
//    }
}