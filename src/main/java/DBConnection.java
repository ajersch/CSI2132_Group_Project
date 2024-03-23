import java.sql.*;

public class DBConnection {

    public static void main(String[] args) {
        try{
            Connection db = DriverManager.getConnection("jdbc:postgresql://localhost:5432/postgres","postgres", "RariJackAppleDash");
            Statement st = db.createStatement();
            ResultSet rs = st.executeQuery("SELECT * FROM \"Hotel\".chain");
            ResultSetMetaData rsmd = rs.getMetaData();
            int numOfColumns = rsmd.getColumnCount();
            System.out.println("number of columns: "+numOfColumns);
            for (int i = 1; i <= rsmd.getColumnCount(); i++) {
                System.out.print(rsmd.getColumnName(i));
                System.out.print("\t\t\t");
            }
            System.out.println();
            while(rs.next()){
                for (int i = 1; i <= rsmd.getColumnCount(); i++) {
                    System.out.print(rs.getString(i));
                    System.out.print("\t");
                }
                System.out.println();
            }
            rs.close();
            st.close();
        } catch (SQLException e) {
            throw new RuntimeException(e);
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
        } catch (Throwable e) {
            System.out.println("connection error: "+e.getMessage());

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
            System.out.println("sql error: "+e.getMessage());
            throw new SQLException("Could not close connection with the Database Server: "
                    + e.getMessage());
        }

    }
}
