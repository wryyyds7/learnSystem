package dao;

import pojo.Page;
import pojo.Topic;
import pojo.User;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class TopicDao extends BaseDao {

    public int addTopic(Topic topic, User user) {
        String sql = "insert into tb_topic values(seq_tb_topic.nextval,?,?,?,?,sysdate,0,?,0,0)";
        int row = update(sql, topic.getBoardId(),user.getUserId(),topic.getTitle(), topic.getContent(), topic.getPicture());
        return row;
    }

    public int delTopic(int topic_id) {
        String sql = "delete from tb_topic where topic_id=?";
        return update(sql, topic_id);
    }

    public int updateTopic(Topic topic) {
        String sql = "update tb_topic set board_id=?,title=?,content=?,release_time=sysdate where topic_id=?";
        return update(sql, topic.getBoardId(), topic.getTitle(), topic.getContent(),topic.getTopicId());
    }

    public int getCount() {
        String sql = "select count(*) from tb_topic";
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
    public List<Topic> findTopic() {
        String sql = "select a.*,user_name,role_id,face from tb_topic a join tb_user b on a.user_id=b.user_id order by release_time desc";
        ResultSet set = select(sql);
        List<Topic> list = new ArrayList<>();
        try {
            while (set.next()) {
                Topic topic = new Topic();
                topic = initTopic(set,topic);
                list.add(topic);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }
    public Topic findTopicByTid(String tid) {
        String sql = "select a.*,user_name,role_id,face from tb_topic a join tb_user b on a.user_id=b.user_id where topic_id=? order by release_time desc";
        ResultSet set = select(sql,tid);
        Topic topic = new Topic();
        try {
            while (set.next()) {
                topic = initTopic(set,topic);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return topic;
    }
    public List<Topic> findTopicByUid(String uid) {
        String sql = "select a.*,user_name,role_id,face from tb_topic a join tb_user b on a.user_id=b.user_id where b.user_id=? order by release_time desc";
        ResultSet set = select(sql,uid);
        List<Topic> list = new ArrayList<>();
        try {
            while (set.next()) {
                Topic topic = new Topic();
                topic = initTopic(set,topic);
                list.add(topic);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public Page findTopicByPage(Page<Topic> page) {
        if (page != null) {
            StringBuffer sb = new StringBuffer();
            sb.append(Page.PAGE_START);
            sb.append("select * from TB_topic where 1=1");
            Topic con = page.getCondition();
            if (con != null) {
                if (con.getTitle() != null && con.getTitle().length() > 0) {
                    sb.append("  and title like '%" + con.getTitle() + "%'");

                }
//                if (con.getBoardId() > 0) {
//                    sb.append("  and a.board_Id=" + con.getBoardId());
//                }
            }
            sb.append("  order by release_time desc");
            sb.append(Page.PAGE_END);
            ResultSet set = select(sb.toString(), page.getEnd(), page.getStart());
            List<Topic> list = new ArrayList<>();
            try {
                while (set.next()) {
                    Topic t = new Topic();
                    t.setBoardId(set.getInt("board_id"));
                    t.setContent(set.getString("content"));
                    t.setReleaseTime(set.getTimestamp("release_time"));
                    t.setRepliesCount(new TopicBackDao().getReplieCount((set.getInt("topic_id"))+""));
                    t.setTitle(set.getString("title"));
                    t.setUserId(set.getInt("user_id"));
                    t.setTopicId(set.getInt("topic_Id"));
                    t.setPicture(set.getString("picture"));
                    t.setTop(set.getInt("top"));
                    t.setHighlight(set.getInt("highlight"));
                    list.add(t);
                }
                page.setList(list);
                return page;
            } catch (Exception e) {
                e.printStackTrace();
            }
        }


        return null;
    }


    //    排序参数 1为时间倒序 2为回复数 默认值为1
    public Page<Topic> findTopicByPage(Page<Topic> page,int boardId,int sortType,int top) {
        if (page != null) {
            StringBuffer sb = new StringBuffer();
            sb.append(Page.PAGE_START);
            sb.append("select a.*,user_name,role_id,face from tb_topic a join tb_user b on a.user_id=b.user_id where 1=1");
            if(boardId>0){
                sb.append("and board_id="+boardId);
            }
            if(top==1){
                sb.append("and top=1");
            }else {
                sb.append("and top=0");
            }
            if (page.getCondition() != null) {
                if (page.getCondition().getTitle() != null) {
                    sb.append(" and topic like '%"+page.getCondition().getTitle() + "%'");
                }
            }
            if(sortType==2){
                sb.append("order by replies_count desc");
            }else {
                sb.append("order by release_time desc");
            }
            sb.append(Page.PAGE_END);
            ResultSet set = select(sb.toString(), page.getEnd(), page.getStart());
            List<Topic> list = new ArrayList<>();
            try {
                while (set.next()) {
                    Topic topic = new Topic();
                    topic = initTopic(set,topic);
                    list.add(topic);
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
            page.setList(list);
            closeAll();
            //查询总记录数
//            sql = "select count(*) from t_topic";
//            set = select(sql);
            sb = new StringBuffer("select count(*) from tb_topic where 1=1");
            if (page.getCondition() != null) {
                if (page.getCondition().getTitle() != null) {
                    sb.append("and topic_name like '%" + page.getCondition().getTitle() + "%'");
                }
            }
            if(boardId>0){
                sb.append("and board_id="+boardId);
            }
            if(top==1){
                sb.append("and top=1");
            }else {
                sb.append("and top=0");
            }
            set = select(sb.toString());
            try {
                while (set.next()) {
                    page.setTotal(set.getLong(1));
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
            closeAll();
        }
        return page;
    }
    public int getRepCount(int tid){
        String sql = "select count(*) from tb_topic_back where topic_id=?";
        int count = 0;
        ResultSet rs = select(sql,tid);
        try {
            while (rs.next()){
                count = rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return count;
    }
    public int top(String tid){
        String sql = "update tb_topic set top=1 where topic_id=?";
        return update(sql, tid);
    }
    public int detop(String tid){
        String sql = "update tb_topic set top=0 where topic_id=?";
        return update(sql, tid);
    }
    public int highlight(String tid){
        String sql = "update tb_topic set highlight=1 where topic_id=?";
        return update(sql, tid);
    }
    public int dehighlight(String tid){
        String sql = "update tb_topic set highlight=0 where topic_id=?";
        return update(sql, tid);
    }

    private Topic initTopic(ResultSet rs, Topic topic) {
        try {
            topic.setBoardId(rs.getInt("board_id"));
            topic.setContent(rs.getString("content"));
            topic.setReleaseTime(rs.getTimestamp("release_time"));
            topic.setRepliesCount(getRepCount(Integer.valueOf(rs.getInt("topic_Id"))));
            topic.setTitle(rs.getString("title"));
            topic.setUserId(rs.getInt("user_id"));
            topic.setTopicId(rs.getInt("topic_Id"));
            topic.setPicture(rs.getString("picture"));
            topic.setTop(rs.getInt("top"));
            topic.setHighlight(rs.getInt("highlight"));
            topic.setUserName(rs.getString("user_name"));
            topic.setRoleId(rs.getInt("role_id"));
            topic.setFace(rs.getString("face"));
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return topic;
    }
}
