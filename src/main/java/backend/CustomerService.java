package backend;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class CustomerService {
    public void createCutsomer(Customer customer) {
        try {
            DBConnection dbConnection = new DBConnection();
            Connection con = dbConnection.getConnection();

            String sql = "";
        } catch (Exception e) {
            System.out.println("Error creating customer");
        }
    }
}
