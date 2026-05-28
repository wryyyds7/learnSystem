package dao;

import pojo.Answer;
import pojo.Page;
import pojo.Question;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

public class QuestionDao extends BaseDao{
    public int addQuestion(Question question){
        String sql = "insert into t_questions values(seq_t_questions.nextval,?,?,sysdate)";
        int row = update(sql,question.getQuestion(),question.getTypeId());
        return row;
    }
    public int findQuestion(String question){
        String sql="select question_id from t_questions where question=?";
        ResultSet set= select(sql,question);
        try {
           while (set.next()){
               return set.getInt(1);
           }
        } catch (SQLException e) {
            e.printStackTrace();
        }finally {
            closeAll();
        }
        return 0;
    }
    public List<Question> findQuestionByPage(Page<Question> page) {
        StringBuffer sb = new StringBuffer();
        sb.append(Page.PAGE_START);
        sb.append("select c.*,type_name  from t_questions c inner join t_type d on c.TYPE_ID=d.TYPE_ID where 1=1");
        if (page.getCondition() != null) {
            if (page.getCondition().getQuestion() != null && page.getCondition().getQuestion().length() > 0) {
                sb.append("    and question like '%" + page.getCondition().getQuestion() + "%'");
            }
            if (page.getCondition().getStartTime()!=null){
                sb.append("  and add_time>to_date('" + page.getCondition().getStartTime()+"','yyyy-mm-dd')");
            }
            if (page.getCondition().getEndTime()!=null){
                sb.append(" and add_time<to_date('" + page.getCondition().getEndTime()+"','yyyy-mm-dd')");
            }
            if (page.getCondition().getTypeId()>0){
                sb.append("  and c.type_id="+page.getCondition().getTypeId());
            }
        }
        sb.append(Page.PAGE_END);
        ResultSet set = select(sb.toString(), page.getEnd(), page.getStart());
        List<Question> list = new ArrayList<>();
        try {
            while (set.next()) {
                Question q=new Question();
                q.setQuestionId(set.getInt("question_id"));
                q.setQuestion(set.getString("question"));
                q.setTypeId(set.getInt("type_id"));
                q.setAddTime(set.getTimestamp("add_time"));
                q.setTypeName(set.getString("type_name"));
                list.add(q);
            }
            return list;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
    public long countQuestionPage(Question question){
        StringBuffer sb=new StringBuffer("select count(*) from t_questions c inner join t_type d on c.TYPE_ID=d.TYPE_ID where 1=1");
        if (question!=null){
            if (question.getQuestion()!= null) {
                if (question.getQuestion() != null && question.getQuestion().length() > 0) {
                    sb.append("    and question like '%" + question.getQuestion() + "%'");
                }
                if (question.getStartTime()!=null){
                    sb.append("  and add_time>to_date('" + question.getStartTime()+"','yyyy-mm-dd')");
                }
                if (question.getEndTime()!=null){
                    sb.append(" and add_time<to_date('" + question.getEndTime()+"','yyyy-mm-dd')");
                }
                if (question.getTypeId()>0){
                    sb.append("  and c.type_id="+question.getTypeId());
                }
            }
        }
        ResultSet set=select(sb.toString());
        try {
            while (set.next()){
                return set.getLong(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }finally {
            closeAll();
        }
        return 0;
    }
    public int del(int questionId){
        String sql="delete from t_questions where question_id=?";
        int row=update(sql,questionId);
        return row;
    }
    public Question findQuestionById(int questionId){
        String sql="select * from t_questions where question_id=?";
        ResultSet set=select(sql,questionId);
        Question q=null;
        try {
            while (set.next()){
                q=new Question();
                q.setQuestionId(set.getInt("question_id"));
                q.setQuestion(set.getString("question"));
                q.setTypeId(set.getInt("type_id"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }finally {
            closeAll();
        }
        return q;
    }
    public int update(Question question){
        String sql="update t_questions set question=? where question_id=?";
        return update(sql,question.getQuestion(),question.getQuestionId());
    }
}
