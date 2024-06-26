package backend;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class CustomerService {
    /**
     * creates a customer
     * @param customer the customer to be created
     */
    public void createCutsomer(Customer customer) {
        try {
            DBConnection dbConnection = new DBConnection();
            Connection con = dbConnection.getConnection();

            String sql = "INSERT INTO Customer " +
                         "VALUES (?, ?, ?, ?, ?, ?, ?, CAST(? AS DATE));";

            PreparedStatement ps = con.prepareStatement(sql);

            ps.setInt(1, customer.getSin());
            ps.setString(2, customer.getFirstName());
            ps.setString(3, customer.getLastName());
            ps.setInt(4, customer.getStreetNumber());
            ps.setString(5, customer.getStreetName());
            ps.setString(6, customer.getCity());
            ps.setString(7, customer.getCountry());
            ps.setString(8, customer.getRegistrationDate());

            ps.executeUpdate();

            ps.close();
            dbConnection.close();
        } catch (Exception e) {
            System.out.println("Error creating customer");
            e.printStackTrace();
        }
    }

    /**
     * deletes a customer
     * @param customerSin the sin of the customer to be deleted
     */
    public void deleteCustomer(int customerSin) {
        try {
            DBConnection dbConnection = new DBConnection();
            Connection con = dbConnection.getConnection();

            String sql = "UPDATE Customer " +
                         "SET archived = TRUE " +
                         "WHERE sin = ?;";

            PreparedStatement ps = con.prepareStatement(sql);

            ps.setInt(1, customerSin);

            ps.executeUpdate();

            ps.close();
            dbConnection.close();
        } catch (Exception e) {
            System.out.println("Error deleting customer");
            e.printStackTrace();
        }
    }

    /**
     * Updates a customer
     * @param customer a customer object with the updated information
     */
    public void updateCustomer(Customer customer) {
        try {
            DBConnection dbConnection = new DBConnection();
            Connection con = dbConnection.getConnection();

            String sql = "UPDATE Customer " +
                         "SET first_name = ?, last_name = ?, street_number = ?, street_name = ?, city = ?, country = ?, registration_date = CAST(? AS DATE) " +
                         "WHERE sin = ?;";

            PreparedStatement ps = con.prepareStatement(sql);

            ps.setString(1, customer.getFirstName());
            ps.setString(2, customer.getLastName());
            ps.setInt(3, customer.getStreetNumber());
            ps.setString(4, customer.getStreetName());
            ps.setString(5, customer.getCity());
            ps.setString(6, customer.getCountry());
            ps.setString(7, customer.getRegistrationDate());
            ps.setInt(8, customer.getSin());

            ps.executeUpdate();

            ps.close();
            dbConnection.close();
        } catch (Exception e) {
            System.out.println("Error updating customer");
            e.printStackTrace();
        }
    }

    /**
     * Finds the first and last name of a
     * @param sin
     * @return
     */
    public Customer getCustomer(int sin) {
        Customer customer = null;
        try {
            DBConnection dbConnection = new DBConnection();
            Connection con = dbConnection.getConnection();

            String sql = "SELECT * " +
                    "FROM Customer " +
                    "WHERE sin = ? " +
                    "AND archived = FALSE;";

            PreparedStatement ps = con.prepareStatement(sql);

            ps.setInt(1, sin);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                customer = new Customer(
                        sin,
                        rs.getString("first_name"),
                        rs.getString("last_name"),
                        rs.getInt("street_number"),
                        rs.getString("street_name"),
                        rs.getString("city"),
                        rs.getString("country"),
                        rs.getString("registration_date"),
                        false
                );
            }

            rs.close();
            ps.close();
            dbConnection.close();
        } catch (Exception e) {
            System.out.println("Error getting customer name");
            e.printStackTrace();
        }

        return customer;
    }

    public boolean isCustomer(int sin) {
        boolean isCustomer = false;
        try {
            DBConnection dbConnection = new DBConnection();
            Connection con = dbConnection.getConnection();

            String sql = "SELECT EXISTS(SELECT * FROM Customer WHERE sin = ? AND archived = FALSE);";

            PreparedStatement ps = con.prepareStatement(sql);

            ps.setInt(1, sin);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                isCustomer = rs.getBoolean(1);
            }

            rs.close();
            ps.close();
            dbConnection.close();
        } catch (Exception e) {
            System.out.println("Error finding customer");
            e.printStackTrace();
        }

        return isCustomer;
    }

    public List<Customer> getAllCustomers() {
        List<Customer> customers = new ArrayList<>();
        try {
            DBConnection dbConnection = new DBConnection();
            Connection con = dbConnection.getConnection();

            String sql = "SELECT * " +
                    "FROM Customer " +
                    "WHERE archived = FALSE;";

            PreparedStatement ps = con.prepareStatement(sql);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Customer customer = new Customer(
                        rs.getInt("sin"),
                        rs.getString("first_name"),
                        rs.getString("last_name"),
                        rs.getInt("street_number"),
                        rs.getString("street_name"),
                        rs.getString("city"),
                        rs.getString("country"),
                        rs.getString("registration_date"),
                        rs.getBoolean("archived")
                );
                customers.add(customer);
            }

            rs.close();
            ps.close();
            dbConnection.close();
        } catch (Exception e) {
            System.out.println("Error getting all customers");
            e.printStackTrace();
        }

        return customers;
    }
}
