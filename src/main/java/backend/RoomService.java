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
    public void deleteRoom(int roomId) {
        try {
            DBConnection dbConnection = new DBConnection();
            Connection con = dbConnection.getConnection();

            String sql = "UPDATE Room " +
                         "SET archived = TRUE " +
                         "WHERE room_id = ?;";

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

    /**
     * queries the view of rooms per area
     * @return a list of pairs of city and total rooms in the area
     */
    public List<Pair<String, Integer>> getRoomsInArea() {
        List<Pair<String, Integer>> roomsInArea = new ArrayList<>();

        try {
            DBConnection dbConnection = new DBConnection();
            Connection con = dbConnection.getConnection();

            String sql = "SELECT * FROM Area_Rooms;";

            PreparedStatement ps = con.prepareStatement(sql);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Pair<String, Integer> pair = new Pair<>(rs.getString("city"), rs.getInt("total_rooms"));
                roomsInArea.add(pair);
            }

            rs.close();
            ps.close();
            dbConnection.close();
        } catch (Exception e) {
            System.out.println("Error getting rooms in area");
            e.printStackTrace();
        }

        return roomsInArea;
    }

    /**
     * gets the room number of a room
     * @param roomId the id of the room
     * @return the room number
     */
    public int getRoomNumber(int roomId) {
        int roomNumber = -1;
        try {
            DBConnection dbConnection = new DBConnection();
            Connection con = dbConnection.getConnection();

            String sql = "SELECT room_number FROM Room WHERE room_id = ?;";

            PreparedStatement ps = con.prepareStatement(sql);

            ps.setInt(1, roomId);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                roomNumber = rs.getInt("room_number");
            }

            rs.close();
            ps.close();
            dbConnection.close();
        } catch (Exception e) {
            System.out.println("Error getting room number");
            e.printStackTrace();
        }
        return roomNumber;
    }

    public boolean isCheckedIn(int roomId) {
        boolean checkedIn = false;
        try {
            DBConnection dbConnection = new DBConnection();
            Connection con = dbConnection.getConnection();

            String sql = "SELECT EXISTS(SELECT * FROM Checks_In WHERE room_id = ?);";

            PreparedStatement ps = con.prepareStatement(sql);

            ps.setInt(1, roomId);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                checkedIn = rs.getBoolean(1);
            }

            rs.close();
            ps.close();
            dbConnection.close();
        } catch (Exception e) {
            System.out.println("Error checking if room is checked in");
            e.printStackTrace();
        }

        return checkedIn;
    }

    public List<Room> getAllRooms() {
        List<Room> rooms = new ArrayList<>();

        try {
            DBConnection dbConnection = new DBConnection();
            Connection con = dbConnection.getConnection();

            String sql = "SELECT * FROM Room WHERE archived = FALSE ORDER BY hotel_id;";

            PreparedStatement ps = con.prepareStatement(sql);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Room room = new Room(
                    rs.getInt("room_id"),
                    rs.getInt("hotel_id"),
                    rs.getFloat("price"),
                    rs.getInt("capacity"),
                    rs.getBoolean("extendable"),
                    rs.getInt("room_number"),
                    rs.getBoolean("archived")
                );

                rooms.add(room);
            }

            rs.close();
            ps.close();
            dbConnection.close();
        } catch (Exception e) {
            System.out.println("Error getting all rooms");
            e.printStackTrace();
        }

        return rooms;
    }

    public Room getRoom(int roomId) {
        Room room = null;

        try {
            DBConnection dbConnection = new DBConnection();
            Connection con = dbConnection.getConnection();

            String sql = "SELECT * FROM Room WHERE room_id = ? AND archived = FALSE;";

            PreparedStatement ps = con.prepareStatement(sql);

            ps.setInt(1, roomId);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                room = new Room(
                        rs.getInt("room_id"),
                        rs.getInt("hotel_id"),
                        rs.getFloat("price"),
                        rs.getInt("capacity"),
                        rs.getBoolean("extendable"),
                        rs.getInt("room_number"),
                        rs.getBoolean("archived")
                );
            }

            rs.close();
            ps.close();
            dbConnection.close();
        } catch (Exception e) {
            System.out.println("Error getting room");
            e.printStackTrace();
        }

        return room;
    }
}
