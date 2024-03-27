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
    public List<Booking> getCustomerBookings(int customerId) {
        //make an empty list of bookings to begin
        List<Booking> bookings = new ArrayList<>();

        //try catch block in case we can't connect to the server
        try {
            //use the DBConnection class to get a connection to the database
            DBConnection dbConnection = new DBConnection();
            Connection con = dbConnection.getConnection();

            //make the sql statement with ? for values that get replaced by variables
            String sql = "SELECT * FROM booking" +
                         "WHERE customer_sin = ?;";

            //prepared statement is what we use to execute it
            PreparedStatement ps = con.prepareStatement(sql);

            //set the values of the ? in the sql statement to our variables
            ps.setInt(1, customerId);

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
            e.printStackTrace();
        }
        return bookings;
    }

    public void checkIn(int roomId, String startDate, int employeeSin) {
        try {
            DBConnection dbConnection = new DBConnection();
            Connection con = dbConnection.getConnection();

            String sql = "INSERT INTO Checks_In" +
                         "VALUES (?, ?, ?);";

            PreparedStatement ps = con.prepareStatement(sql);

            ps.setInt(1, roomId);
            ps.setString(2, startDate);
            ps.setInt(3, employeeSin);

            ps.executeUpdate();

            ps.close();
            dbConnection.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}