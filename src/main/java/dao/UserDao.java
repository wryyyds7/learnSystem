package dao;

import pojo.Page;
import pojo.User;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class UserDao extends BaseDao {

    public int addUser(User user) {
        for (User u : findUser()) {
            if (u.getUserName().equals(user.getUserName())) {
                return 0;
            }
        }
        String sql = "insert into tb_user (user_id,user_name,user_pwd,tel,face) values (seq_tb_user.nextval,?,?,?,'images/face/default_face.png')";
        return update(sql, user.getUserName(), user.getUserPwd(), user.getTel());
    }

    public int delUser(int userId) {
        String sql = "delete from tb_user where user_id=?";
        return update(sql, userId);
    }

    public int getCount() {
        String sql = "select count(*) from tb_user";
        ResultSet rs = select(sql);
        System.out.println(rs);
        try {
            while (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    public List<User> findUser() {
        String sql = "select * from tb_user";
        ResultSet rs = select(sql);
        List<User> list = new ArrayList<>();
        try {
            while (rs.next()) {
                User user = new User();
                user = initUser(rs, user);
                list.add(user);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public Page<User> findUserByPage(Page<User> page) {
        StringBuffer sb = new StringBuffer();
        sb.append(Page.PAGE_START);
        sb.append("select * from tb_user where 1=1");
        User con = page.getCondition();
        if (con != null) {
            if (con.getUserName() != null) {
                sb.append("and user_name like '%" + con.getUserName() + "%'");
            }
            if (con.getRoleId() > 0) {
                sb.append("and role_id=" + con.getRoleId());
            }
            if (con.getBan() != 0) {
                sb.append("and ban=" + con.getBan());
            }
        }
        sb.append("order by user_id desc");
        sb.append(Page.PAGE_END);
        ResultSet rs = select(sb.toString(), page.getEnd(), page.getStart());
        List<User> list = new ArrayList<>();
        try {
            while (rs.next()) {
                User user = new User();
                user = initUser(rs, user);
                list.add(user);
            }
            page.setList(list);
            closeAll();
        } catch (SQLException e) {
            e.printStackTrace();
        }

        sb = new StringBuffer("select count(*) from tb_user where 1=1");
        if (con != null) {
            if (con.getUserName() != null) {
                sb.append("and user_name like '%" + con.getUserName() + "%'");
            }
            if (con.getRoleId() > 0) {
                sb.append("and role_id=" + con.getRoleId());
            }
            if (con.getBan() != 0) {
                sb.append("and ban=" + con.getBan());
            }
        }
        rs = select(sb.toString());
        try {
            while (rs.next()) {
                page.setTotal(rs.getLong(1));
            }
            closeAll();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return page;
    }

    public User findUserById(int userId) {
        String sql = "select * from tb_user where user_id=?";
        ResultSet rs = select(sql, userId);
        try {
            while (rs.next()) {
                User user = new User();
                user = initUser(rs, user);
                return user;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public int updateUser(User user) {
        StringBuffer sb = new StringBuffer("update tb_user set user_id=");
        sb.append(user.getUserId());
        if (user.getUserPwd() != null) {
            sb.append(",user_pwd='" + user.getUserPwd() + "'");
        }
        if (user.getTel() != null) {
            sb.append(",tel=" + user.getTel());
        }
        if (user.getFace() != null) {
            sb.append(",face='" + user.getFace() + "'");
        }
        if (user.getGenderId() > 0) {
            sb.append(",gender=" + user.getGenderId());
        }
        if (user.getBir() != null) {
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            sb.append(",birthday=to_date('" + sdf.format(user.getBir())+"','yyyy-mm-dd')");
            sdf = new SimpleDateFormat("yyyy");
            int age = Integer.valueOf(sdf.format(new Date())) - Integer.valueOf(sdf.format(user.getBir()));
            sb.append(",age=" + String.valueOf(age));
        }
        if (user.getEmail()!=null){
            sb.append(",email='"+user.getEmail()+"'");
        }
        if (user.getIntroduction()!=null){
            sb.append(",introduction='"+user.getIntroduction()+"'");
        }
        sb.append(" where user_id=?");
        return update(sb.toString(), user.getUserId());
    }

    public User login(String userName, String userPwd) {
        String sql = "select * from tb_user where user_name=? and user_pwd=?";
        ResultSet rs = select(sql, userName, userPwd);
        try {
            while (rs.next()) {
                User user = new User();
                user = initUser(rs, user);
                return user;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    private User initUser(ResultSet rs, User user) {
        try {
            user.setUserId(rs.getInt("user_id"));
            user.setUserName(rs.getString("user_name"));
            user.setUserPwd(rs.getString("user_pwd"));
            user.setTel(rs.getString("tel"));
            user.setRoleId(rs.getInt("role_id"));
            user.setBan(rs.getInt("ban"));
            user.setFace(rs.getString("face"));
            user.setGenderId(rs.getInt("gender"));
            user.setAge(rs.getInt("age"));
            user.setBir(rs.getDate("birthday"));
            if(user.getBir()!=null){
                user.setBirthday(new SimpleDateFormat("yyyy-MM-dd").format(user.getBir()));
            }
            user.setEmail(rs.getString("email"));
            user.setIntroduction(rs.getString("introduction"));
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return user;
    }
}
