import java.sql.*;

public class DBConnection {

    public static void main(String[] args) {
        try {
            Connection db = DBConnection.getConnection();

            Statement st = db.createStatement();
            ResultSet rs = st.executeQuery("SELECT * FROM Chain");

            while (rs.next()) {
                System.out.println(rs.getString(1));
            }
            rs.close();
            st.close();
            db.close();
        } catch(Exception e) {
            System.out.println("Exception");
        }
    }
    private static final String ipAddress = "127.0.0.1";
    private static final String dbServerPort = "5432";
    private static final String dbName = "postgres";
    private static final String dbusername = "postgres";
    private static final String dbpassword = "admin";

    public static Connection con = null;

    /**
     * Establishes a connection with the database, initializes and returns
     * the Connection object.
     *
     * @return Connection, the Connection object
     * @throws Exception
     */
    public static Connection getConnection() throws Exception {
        try {
            Class.forName("org.postgresql.Driver");
            con = DriverManager.getConnection("jdbc:postgresql://"
                    + ipAddress + ":" + dbServerPort + "/" + dbName, dbusername, dbpassword);
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
    public static void close() throws SQLException {
        try {
            if (con != null)
                con.close();
        } catch (SQLException e) {
            throw new SQLException("Could not close connection with the Database Server: "
                    + e.getMessage());
        }

    }
}
