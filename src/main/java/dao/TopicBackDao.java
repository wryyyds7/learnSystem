package dao;

import pojo.Page;
import pojo.TopicBack;
import pojo.User;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class TopicBackDao extends BaseDao {
    public List<TopicBack> findTopicBack(){
        ResultSet set=select("select * from tb_topic_back");
        List<TopicBack> list=new ArrayList<>();
        try {
            while (set.next()){
                TopicBack topicBack=new TopicBack();
                topicBack = initTopicBack(set,topicBack);
                list.add(topicBack);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
       return list;
    }
    public List<TopicBack> findTopicBackByUid(String uid){
        ResultSet set=select("select * from tb_topic_back where user_id=?",uid);
        List<TopicBack> list=new ArrayList<>();
        try {
            while (set.next()){
                TopicBack topicBack=new TopicBack();
                topicBack = initTopicBack(set,topicBack);
                list.add(topicBack);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
       return list;
    }
    public int getReplieCount(String tid){
        ResultSet set=select("select count(*) from tb_topic_back where topic_id=?",tid);
        int count = 0;
        try {
            while (set.next()){
                count = set.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
       return count;
    }

    public int getCount() {
        String sql = "select count(*) from tb_topic_back";
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

    public int addTopicBack(User user,TopicBack topicBack) {
        String sql = "insert into tb_topic_back values(seq_tb_topic.nextval,?,?,?,sysdate)";
        int row = update(sql,topicBack.getTopicId(),user.getUserId(),topicBack.getContent());
        return row;
    }
    public int delTopicBack(int topic_Back_id) {
        String sql = "delete from tb_topic_back where topic_id=?";
        return update(sql, topic_Back_id);
    }
    public int updateTopicBack(TopicBack topicBack){
        String sql="update tb_topic_back set content=?,release_time=sysdate where topic_back_id=?";
        return update(sql,topicBack.getContent(),topicBack.getTopicBackId());
    }
    public Page<TopicBack> findTopicBackByPage(Page<TopicBack> page) {
        StringBuffer sb = new StringBuffer();
        sb.append(Page.PAGE_START);
        sb.append("select a.*,user_name,role_id,face from tb_topic_back a join tb_user b on a.user_id=b.user_id where 1=1");
        TopicBack con = page.getCondition();
        if (con != null) {
            if (con.getUserId()> 0) {
                sb.append("   and user_id=" + con.getUserId());
            }
            if (con.getTopicId()>0) {
                sb.append("   and topic_id=" + con.getTopicId());
            }
        }
        sb.append("order by topic_id desc");
        sb.append(Page.PAGE_END);
        ResultSet rs = select(sb.toString(), page.getEnd(), page.getStart());
        List<TopicBack> list = new ArrayList<>();
        try {
            while (rs.next()) {
                TopicBack topicBack = new TopicBack();
                topicBack = initTopicBack(rs, topicBack);
                list.add(topicBack);
            }
            page.setList(list);
            closeAll();
        } catch (SQLException e) {
            e.printStackTrace();
        }

        sb = new StringBuffer("select count(*) from tb_topic_back where 1=1");
        if (con != null) {
            if (con.getUserId()> 0) {
                sb.append("   and user_id=" + con.getUserId());
            }
            if (con.getTopicId()>0) {
                sb.append("   and topic_id=" + con.getTopicId());
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
    private TopicBack initTopicBack(ResultSet rs, TopicBack topicBack) {
        try {
            topicBack.setTopicBackId(rs.getInt("topic_back_id"));
            topicBack.setUserId(rs.getInt("user_id"));
            topicBack.setTopicId(rs.getInt("topic_id"));
            topicBack.setContent(rs.getString("content"));
            topicBack.setReleaseTime(rs.getTimestamp("release_Time"));
            topicBack.setUserName(rs.getString("user_name"));
            topicBack.setRoleId(rs.getInt("role_id"));
            topicBack.setFace(rs.getString("face"));
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return topicBack;
    }
}
