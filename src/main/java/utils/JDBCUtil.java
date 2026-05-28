package utils;

import java.sql.*;

public class JDBCUtil {

    private static final String URL = "jdbc:mysql://localhost:3306/learnsys?useSSL=false&serverTimezone=UTC&allowPublicKeyRetrieval=true";
    private static final String USER_NAME = "root";
    private static final String USER_PSW = "root";

    /**
     * 返回数据库连接
     *
     * @return
     */
    public static Connection getConn() {
        try {
            Class.forName("com.mysql.jdbc.Driver");
            Connection conn = DriverManager.getConnection(URL, USER_NAME, USER_PSW);
            return conn;
        } catch (ClassNotFoundException e) {
            // TODO 自动生成的 catch 块
            e.printStackTrace();
            System.out.println("ORACLE驱动未找到");
        } catch (SQLException e) {
            // TODO 自动生成的 catch 块
            e.printStackTrace();
            System.out.println("连接数据库失败");
        }
        return null;
    }

    /**
     * 关闭所有连接对象
     *
     * @param conn
     * @param stm
     * @param set
     */
    public static void closeAll(Connection conn, PreparedStatement stm, ResultSet set) {
        try {
            if (set != null)
                set.close();
        } catch (SQLException e) {
            // TODO 自动生成的 catch 块
            e.printStackTrace();
        }
        try {
            if (stm != null)
                stm.close();
        } catch (SQLException e) {
            // TODO 自动生成的 catch 块
            e.printStackTrace();
        }
        try {
            if (conn != null)
                conn.close();
        } catch (SQLException e) {
            // TODO 自动生成的 catch 块
            e.printStackTrace();
        }

    }

    /**
     * 关闭所有连接对象
     *
     * @param conn
     * @param stm
     */
    public static void closeAll(Connection conn, PreparedStatement stm) {
        try {
            stm.close();
        } catch (SQLException e) {
            // TODO 自动生成的 catch 块
            e.printStackTrace();
        }
        try {
            conn.close();
        } catch (SQLException e) {
            // TODO 自动生成的 catch 块
            e.printStackTrace();
        }
    }
}