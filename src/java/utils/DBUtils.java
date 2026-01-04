package utils;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

public class DBUtils {
    
    private static final String DB_NAME = "NoteTakingDB";
    private static final String DB_USER_NAME = "sa";
    private static final String DB_PASSWORD = "12345";
    
    /**
     * Get database connection
     * @return Connection object
     * @throws ClassNotFoundException if JDBC driver not found
     * @throws SQLException if connection fails
     */
    public static Connection getConnection() throws ClassNotFoundException, SQLException {
        Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
        String url = "jdbc:sqlserver://localhost:1433;databaseName=" + DB_NAME 
                   + ";encrypt=true;trustServerCertificate=true";
        return DriverManager.getConnection(url, DB_USER_NAME, DB_PASSWORD);
    }
    
    /**
     * Test database connection
     * @param args command line arguments
     */
    public static void main(String[] args) {
        try {
            Connection conn = DBUtils.getConnection();
            if (conn != null) {
                System.out.println("✅ Kết nối database thành công!");
                System.out.println("Connection: " + conn);
                conn.close();
            }
        } catch (ClassNotFoundException | SQLException ex) {
            System.err.println("❌ Kết nối database thất bại!");
            Logger.getLogger(DBUtils.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
}
