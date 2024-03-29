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
            e.printStackTrace();
        }
    }

    /**
     * Deletes a chain from the database
     * @param chainName the name of the chain to be deleted
     */
    public void deleteChain(String chainName) {
        try {
            DBConnection dbConnection = new DBConnection();
            Connection con = dbConnection.getConnection();

            String sql = "UPDATE Chain " +
                         "SET archived = TRUE " +
                         "WHERE name = ?;";

            PreparedStatement ps = con.prepareStatement(sql);

            ps.setString(1, chainName);

            ps.executeUpdate();

            ps.close();
            dbConnection.close();
        } catch (Exception e) {
            System.out.println("Error deleting chain");
            e.printStackTrace();
        }
    }

    /**
     * Updates a chain
     * @param chain a chain object with the updated information
     */
    public void updateChain(Chain chain) {
        try {
            DBConnection dbConnection = new DBConnection();
            Connection con = dbConnection.getConnection();

            String sql = "UPDATE Chain " +
                         "SET street_number = ?, street_name = ?, city = ?, country = ?, name = ?, archived = ? " +
                         "WHERE name = ?;";

            PreparedStatement ps = con.prepareStatement(sql);

            ps.setInt(1, chain.getStreetNumber());
            ps.setString(2, chain.getStreetName());
            ps.setString(3, chain.getCity());
            ps.setString(4, chain.getCountry());
            ps.setString(5, chain.getName());
            ps.setBoolean(6, chain.isArchived());
            ps.setString(7, chain.getName());

            ps.executeUpdate();

            ps.close();
            dbConnection.close();
        } catch (Exception e) {
            System.out.println("Error updating chain");
            e.printStackTrace();
        }
    }

    public List<Chain> getAllChains() {
        List<Chain> chains = new ArrayList<>();
        try {
            DBConnection dbConnection = new DBConnection();
            Connection con = dbConnection.getConnection();

            String sql = "SELECT * FROM Chain WHERE archived = FALSE ORDER BY name;";

            PreparedStatement ps = con.prepareStatement(sql);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Chain chain = new Chain(
                    rs.getInt("street_number"),
                    rs.getString("street_name"),
                    rs.getString("city"),
                    rs.getString("country"),
                    rs.getString("name"),
                    rs.getBoolean("archived")
                );

                chains.add(chain);
            }

            rs.close();
            ps.close();
            dbConnection.close();
        } catch (Exception e) {
            System.out.println("Error getting all chains");
            e.printStackTrace();
        }
        return chains;
    }
}