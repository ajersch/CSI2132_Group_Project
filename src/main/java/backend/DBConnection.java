package backend;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;


public class DBConnection {

    /* Database connection settings, change dbName, dbusername, dbpassword */
    private final String dbusername = "postgres";
    private final String dbpassword = "RariJackAppleDash";


    private Connection con = null;

    /**
     * Establishes a connection with the database, initializes and returns
     * the Connection object.
     *
     * @return Connection, the Connection object
     * @throws Exception
     */
    public Connection getConnection() throws Exception {
        try {
            Class.forName("org.postgresql.Driver");
            con = DriverManager.getConnection("jdbc:postgresql://localhost:5432/postgres", dbusername, dbpassword);
            return con;
        } catch (Exception e) {

            throw new Exception("Could not establish connection with the Database Server: "
                    + e.getMessage());
        }

    }

    /**
     * Close database connection. It is very important to close the database connection
     * after it is used.
     *
     * @throws SQLException
     */
    public void close() throws SQLException {
        try {
            if (con != null)
                con.close();
        } catch (SQLException e) {
            throw new SQLException("Could not close connection with the Database Server: "
                    + e.getMessage());
        }

    }
}