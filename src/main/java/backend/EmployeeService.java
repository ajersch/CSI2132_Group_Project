package backend;


import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class EmployeeService {
    public void createEmployee(Employee employee) {
        try {
            DBConnection dbConnection = new DBConnection();

            Connection con = dbConnection.getConnection();

            String sql = "INSERT INTO Employee " +
                         "VALUES (?, ?, ?, ?, ?, ?, ?)";

            PreparedStatement ps = con.prepareStatement(sql);

            ps.setInt(1, employee.getSin());
            ps.setString(2, employee.getFirstName());
            ps.setString(3, employee.getLastName());
            ps.setInt(4, employee.getStreetNumber());
            ps.setString(5, employee.getStreetName());
            ps.setString(6, employee.getCity());
            ps.setString(7, employee.getCountry());

            ps.executeUpdate();

            ps.close();
            dbConnection.close();
        } catch (Exception e) {
            System.out.println("Error creating employee");
            e.printStackTrace();
        }
    }

    public void deleteEmployee(int sin) {
        try {
            DBConnection dbConnection = new DBConnection();
            Connection con = dbConnection.getConnection();

            String sql = "DELETE FROM Employee " +
                         "WHERE sin = ?;";

            PreparedStatement ps = con.prepareStatement(sql);

            ps.setInt(1, sin);

            ps.executeUpdate();

            ps.close();
            dbConnection.close();
        } catch (Exception e) {
            System.out.println("Error deleting employee");
            e.printStackTrace();
        }
    }

    public void updateEmployee(Employee employee) {
        try {
            DBConnection dbConnection = new DBConnection();
            Connection con = dbConnection.getConnection();

            String sql = "UPDATE Employee " +
                         "SET first_name = ?, last_name = ?, street_number = ?, street_name = ?, city = ?, country = ?, archived = ? " +
                         "WHERE sin = ?;";

            PreparedStatement ps = con.prepareStatement(sql);

            ps.setString(1, employee.getFirstName());
            ps.setString(2, employee.getLastName());
            ps.setInt(3, employee.getStreetNumber());
            ps.setString(4, employee.getStreetName());
            ps.setString(5, employee.getCity());
            ps.setString(6, employee.getCountry());
            ps.setBoolean(7, employee.isArchived());
            ps.setInt(8, employee.getSin());

            ps.executeUpdate();

            ps.close();
            dbConnection.close();
        } catch (Exception e) {
            System.out.println("Error updating employee");
            e.printStackTrace();
        }
    }

    public boolean isEmployee(int sin) {
        boolean isEmployee = false;
        try {
            DBConnection dbConnection = new DBConnection();
            Connection con = dbConnection.getConnection();

            String sql = "SELECT EXISTS(SELECT * FROM Employee WHERE sin = ?);";

            PreparedStatement ps = con.prepareStatement(sql);

            ps.setInt(1, sin);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                isEmployee = rs.getBoolean(1);
            }

            rs.close();
            ps.close();
            dbConnection.close();
        } catch (Exception e) {
            System.out.println("Error checking if employee");
            e.printStackTrace();
        }

        return isEmployee;
    }
}
