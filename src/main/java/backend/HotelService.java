package backend;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class HotelService {
    /**
     * Creates a hotel
     * @param hotel the hotel to be created
     */
    public void createHotel(Hotel hotel) {
        try {
            DBConnection dbConnection = new DBConnection();
            Connection con = dbConnection.getConnection();

            String sql = "INSERT INTO Hotel (street_number, street_name, city, country, chain_name, name, stars) " +
                         "VALUES (?, ?, ?, ?, ?, ?, ?);";

            PreparedStatement ps = con.prepareStatement(sql);

            ps.setInt(1, hotel.getStreetNumber());
            ps.setString(2, hotel.getStreetName());
            ps.setString(3, hotel.getCity());
            ps.setString(4, hotel.getCountry());
            ps.setString(5, hotel.getChainName());
            ps.setString(6, hotel.getName());
            ps.setInt(7, hotel.getStars());

            ps.executeUpdate();

            ps.close();
            dbConnection.close();
        } catch (Exception e) {
            System.out.println("Error creating hotel");
            e.printStackTrace();
        }
    }

    /**
     * Deletes a hotel from the database
     * @param hotelId the id of the hotel to be deleted
     */
    public void deleteHotel(int hotelId) {
        try {
            DBConnection dbConnection = new DBConnection();
            Connection con = dbConnection.getConnection();

            String sql = "DELETE FROM Hotel " +
                    "WHERE id = ?;";

            PreparedStatement ps = con.prepareStatement(sql);

            ps.setInt(1, hotelId);

            ps.executeUpdate();

            ps.close();
            dbConnection.close();
        } catch (Exception e) {
            System.out.println("Error deleting hotel");
            e.printStackTrace();
        }
    }

    /**
     * Updates a hotel
     * @param hotel a hotel object with the updated information
     */
    public void updateHotel(Hotel hotel) {
        try {
            DBConnection dbConnection = new DBConnection();
            Connection con = dbConnection.getConnection();

            String sql = "UPDATE Hotel SET street_number = ?, street_name = ?, city = ?, country = ?, chain_name = ?, name = ?, stars = ? " +
                         "WHERE id = ?;";

            PreparedStatement ps = con.prepareStatement(sql);

            ps.setInt(1, hotel.getStreetNumber());
            ps.setString(2, hotel.getStreetName());
            ps.setString(3, hotel.getCity());
            ps.setString(4, hotel.getCountry());
            ps.setString(5, hotel.getChainName());
            ps.setString(6, hotel.getName());
            ps.setInt(7, hotel.getStars());
            ps.setInt(8, hotel.getId());

            ps.executeUpdate();

            ps.close();
            dbConnection.close();
        } catch (Exception e) {
            System.out.println("Error updating hotel");
            e.printStackTrace();
        }
    }

    public List<Pair<String, Integer>> getRoomsPerHotel() {
        List<Pair<String, Integer>> roomsPerHotel = new ArrayList<>();

        try {
            DBConnection dbConnection = new DBConnection();
            Connection con = dbConnection.getConnection();

            String sql = "SELECT name, hotel_rooms FROM Num_Rooms;";

            PreparedStatement ps = con.prepareStatement(sql);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Pair<String, Integer> pair = new Pair<>(rs.getString("name"), rs.getInt("hotel_rooms"));
                roomsPerHotel.add(pair);
            }

            rs.close();
            ps.close();
            dbConnection.close();
        } catch (Exception e) {
            System.out.println("Error getting rooms per hotel");
            e.printStackTrace();
        }

        return roomsPerHotel;
    }
}
