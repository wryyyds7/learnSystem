package dao;

import pojo.Type;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class TypeDao extends BaseDao {
    public List<Type> findType(){
        String sql="select * from t_type";
        ResultSet set=select(sql);
        List<Type> list=new ArrayList<>();
        try {
            while (set.next()){
                Type type=new Type();
                type.setTypeId(set.getInt("type_id"));
                type.setTypeName(set.getString("type_name"));
                list.add(type);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }finally {
            closeAll();
        }
        return list;
    }
}
