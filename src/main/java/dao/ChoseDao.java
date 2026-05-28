package dao;

import pojo.Chose;
import pojo.Question;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class ChoseDao extends BaseDao {
    public int addChose(Chose chose){
        String sql = "insert into t_chose values(?,?,?)";
        int row = update(sql,chose.getQuestionId(),chose.getChoseId(),chose.getChose());
        return row;
    }
    public int del(int questionId){
        String sql="delete from t_chose where question_id=?";
        int row=update(sql,questionId);
        return row;
    }
    public List<Chose> findChoseById(int questionId){
        String sql="select * from t_chose where question_id=? ORDER BY CHOSE_ID";
        ResultSet set=select(sql,questionId);
        List<Chose> list=new ArrayList<>();
        try {
            while (set.next()){
                Chose c=new Chose();
                c.setQuestionId(set.getInt("question_id"));
                c.setChoseId(set.getString("chose_id"));
                c.setChose(set.getString("chose"));
                list.add(c);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }finally {
            closeAll();
        }
        return list;
    }
    public int update(Chose chose){
        String sql="update t_chose set chose=? where question_id=? and chose_id=?";
        return update(sql,chose.getChose(),chose.getQuestionId(),chose.getChoseId());
    }
}
