package backend;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class RoomService {
    //make this check if the room is already in the database
    public void createRoom(Room room) {
        try {
            DBConnection dbConnection = new DBConnection();
            Connection con = dbConnection.getConnection();

            String sql = "INSERT INTO Room (hotel_id, price, capacity, extendable, room_number)" +
                         "VALUES (? ,? ,? ,?, ?);";

            PreparedStatement ps = con.prepareStatement(sql);

            ps.setInt(1, room.getHotelId());
            ps.setFloat(2, room.getPrice());
            ps.setInt(3, room.getCapacity());
            ps.setBoolean(4, room.isExtendable());
            ps.setInt(5, room.getRoomNumber());

            ps.executeUpdate();

            ps.close();
            dbConnection.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    /**
     * Deletes a room from the database
     * @param roomId the id of the room to be deleted
     */
    public void removeRoom(int roomId) {
        try {
            DBConnection dbConnection = new DBConnection();
            Connection con = dbConnection.getConnection();

            String sql = "DELETE FROM Room WHERE room_id = ?;";

            PreparedStatement ps = con.prepareStatement(sql);

            ps.setInt(1, roomId);

            ps.executeUpdate();

            ps.close();
            dbConnection.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    /**
     * Updates a room
     * @param room a room object with the updated information
     */
    public void updateRoom(Room room) {
        try {
            DBConnection dbConnection = new DBConnection();
            Connection con = dbConnection.getConnection();

            String sql = "UPDATE Room SET hotel_id = ?, price = ?, capacity = ?, extendable = ?, room_number = ? WHERE room_id = ?;";

            PreparedStatement ps = con.prepareStatement(sql);

            ps.setInt(1, room.getHotelId());
            ps.setFloat(2, room.getPrice());
            ps.setInt(3, room.getCapacity());
            ps.setBoolean(4, room.isExtendable());
            ps.setInt(5, room.getRoomNumber());
            ps.setInt(6, room.getRoomId());

            ps.executeUpdate();

            ps.close();
            dbConnection.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
