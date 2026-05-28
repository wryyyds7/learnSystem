package dao;

import pojo.Answer;
import pojo.Chose;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class AnswerDao extends BaseDao {
    public int addAnswer(Answer answer){
        String sql = "insert into t_answer values(?,?)";
        int row = update(sql,answer.getQuestionId(),answer.getAnswer());
        return row;
    }
    public int del(int questionId){
        String sql="delete from t_answer where question_id=?";
        int row=update(sql,questionId);
        return row;
    }
    public List<Answer> findAnswerById(int questionId){
        String sql="select * from t_answer where question_id=? ORDER BY answer";
        ResultSet set=select(sql,questionId);
        List<Answer> list=new ArrayList<>();
        try {
            while (set.next()){
                Answer a=new Answer();
                a.setQuestionId(set.getInt("question_id"));
                a.setAnswer(set.getString("answer"));
               list.add(a);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }finally {
            closeAll();
        }
        return list;
    }
    public int update(Answer answer){
        String sql="update t_answer set answer=? where quertion_id=?";
        return update(sql,answer.getAnswer(),answer.getQuestionId());
    }

}
