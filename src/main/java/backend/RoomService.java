package backend;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class RoomService {
    //make this check if the room is already in the database
    public void createRoom(int hotelId, float price, int capacity, boolean extendable, int roomNumber) {
        try {
            DBConnection dbConnection = new DBConnection();
            Connection con = dbConnection.getConnection();

            String sql = "INSERT INTO Room (hotel_id, price, capacity, extendable, room_number)" +
                         "VALUES (? ,? ,? ,?, ?);";

            PreparedStatement ps = con.prepareStatement(sql);

            ps.setInt(1, hotelId);
            ps.setFloat(2, price);
            ps.setInt(3, capacity);
            ps.setBoolean(4, extendable);
            ps.setInt(5, roomNumber);

            ps.executeUpdate();

            ps.close();
            dbConnection.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
