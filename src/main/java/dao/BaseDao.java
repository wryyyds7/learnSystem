package dao;

import utils.JDBCUtil;

import java.sql.*;
import java.util.Date;

public class BaseDao {

    private Connection conn = null;
    private PreparedStatement stm = null;
    private ResultSet set = null;
    /**
     * Object...指调用这个方法，传的参数可以不确定
     *
     * @param sql
     * @param param
     * @return
     */
    protected int update(String sql, Object... param) {
        Connection conn = null;
        PreparedStatement stm = null;
        conn = JDBCUtil.getConn();
        try {
            stm = conn.prepareStatement(sql);
            for (int i = 0; i < param.length; i++) {
                Object object = param[i];
                if(object instanceof Date){
                    Date d = (Date) object;
                    stm.setTimestamp(i+1, new Timestamp(d.getTime()));
                }else if (object != null) {
                    stm.setObject(i + 1, param[i]);
                }
            }
            int row = stm.executeUpdate();

            return row;
        } catch (SQLException e) {
            // TODO 自动生成的 catch 块
            e.printStackTrace();
        } finally {
            JDBCUtil.closeAll(conn, stm);
        }
        return 0;
    }

    public ResultSet select(String sql, Object... param) {
        conn = JDBCUtil.getConn();
        try {
            stm = conn.prepareStatement(sql);
            for (int i = 0; i < param.length; i++) {
                Object object = param[i];
                stm.setObject(i + 1, object);
            }
            set = stm.executeQuery();
        } catch (SQLException e) {
            // TODO 自动生成的 catch 块
            e.printStackTrace();
        } finally {
//			JDBCUtil.closeAll(conn, stm);
        }
        return set;
    }

    protected void closeAll(){
        JDBCUtil.closeAll(conn, stm, set);
    }
}