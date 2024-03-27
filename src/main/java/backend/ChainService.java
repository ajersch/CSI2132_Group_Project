package backend;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class ChainService {
    public void createChain(Chain chain) {
        try {
            DBConnection dbConnection = new DBConnection();
            Connection con = dbConnection.getConnection();

            String sql = "INSERT INTO Chain (street_number, street_name, city, country, name)" +
                         "VALUES (? ,? ,? ,?, ?);";

            PreparedStatement ps = con.prepareStatement(sql);

            ps.setInt(1, chain.getStreetNumber());
            ps.setString(2, chain.getStreetName());
            ps.setString(3, chain.getCity());
            ps.setString(4, chain.getCountry());
            ps.setString(5, chain.getName());

            ps.executeUpdate();

            ps.close();
            dbConnection.close();
        } catch (Exception e) {
            System.out.println("Error creating chain");
        }
    }
}
