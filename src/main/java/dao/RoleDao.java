package dao;

import pojo.Role;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class RoleDao extends BaseDao {
    public int getCount() {
        String sql = "select count(*) from tb_role";
        ResultSet rs = select(sql);
        try {
            while (rs.next()) {
                return rs.getInt("count(*)");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    public List<Role> findRole() {
        String sql = "select * from tb_role";
        ResultSet rs = select(sql);
        List<Role> list = new ArrayList<>();
        try {
            while (rs.next()) {
                Role role = new Role();
                role.setRoleId(rs.getInt(1));
                role.setRoleName(rs.getString(2));
                list.add(role);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }
}
