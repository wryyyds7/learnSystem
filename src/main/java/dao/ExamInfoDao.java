package dao;

import pojo.ExamInfo;
import pojo.Page;
import pojo.Question;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class ExamInfoDao extends BaseDao{
    public List<ExamInfo> findExamInfoByPage(Page<ExamInfo> page){
        StringBuffer sb = new StringBuffer();
        sb.append(Page.PAGE_START);
        sb.append("select g.*,SCORE FROM (select e.*,USER_NAME FROM(select c.*,paper_name from T_EXAM_INFO c inner join T_PAPER_INFO d on c.PAPER_ID=d.PAPER_ID) e INNER JOIN TB_USER f ON e.STUDENT_ID=f.USER_ID) g left JOIN T_SCORE h on  g.STUDENT_ID=h.STUDENT_ID AND g.PAPER_ID=h.PAPER_ID WHERE 1=1");
        if (page.getCondition() != null) {
            if (page.getCondition().getPaperName() != null && page.getCondition().getPaperName().length() > 0) {
                sb.append("    and paper_name like '%" + page.getCondition().getPaperName() + "%'");
            }
            if (page.getCondition().getStudentName()!=null){
                sb.append("  and user_name like '%"+page.getCondition().getStudentName()+"%'");
            }
            if (page.getCondition().getIsRead()>-1){
                sb.append("  and is_read="+page.getCondition().getIsRead());
            }
            if (page.getCondition().getIsTested()>-1){
                sb.append("  and is_tested="+page.getCondition().getIsTested());
            }
        }
        sb.append(Page.PAGE_END);
        ResultSet set = select(sb.toString(), page.getEnd(), page.getStart());
        List<ExamInfo> list = new ArrayList<>();
        try {
            while (set.next()) {
                ExamInfo e=new ExamInfo();
                e.setStudentId(set.getInt("student_id"));
                e.setStudentName(set.getString("user_name"));
                e.setPaperId(set.getInt("paper_id"));
                e.setPaperName(set.getString("paper_name"));
                e.setIsRead(set.getInt("is_read"));
                e.setIsTested(set.getInt("is_tested"));
                e.setTeacherName(set.getString("read_name"));
                e.setScore(set.getInt("score"));
                list.add(e);
            }
            return list;
        } catch (SQLException e) {
            e.printStackTrace();
        }finally {
            closeAll();
        }
        return null;
    }
    public long countExamInfoPage(ExamInfo examInfo){
        StringBuffer sb=new StringBuffer("select count(*) FROM (select e.*,USER_NAME FROM(select c.*,paper_name from T_EXAM_INFO c inner join T_PAPER_INFO d on c.PAPER_ID=d.PAPER_ID) e INNER JOIN TB_USER f ON e.STUDENT_ID=f.USER_ID) g left JOIN T_SCORE h on  g.STUDENT_ID=h.STUDENT_ID AND g.PAPER_ID=h.PAPER_ID WHERE 1=1");
        if (examInfo!= null) {
            if (examInfo.getPaperName() != null && examInfo.getPaperName().length() > 0) {
                sb.append("    and paper_name like '%" + examInfo.getPaperName() + "%'");
            }
            if (examInfo.getStudentName()!=null){
                sb.append("  and user_name like '%"+examInfo.getStudentName()+"%'");
            }
            if (examInfo.getIsRead()>-1){
                sb.append("  and is_read="+examInfo.getIsRead());
            }
            if (examInfo.getIsTested()>-1){
                sb.append("  and is_tested="+examInfo.getIsTested());
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
    public int del(int paperId,int studentId){
        String sql="delete from t_exam_info where paper_id=? and student_id=?";
        int row=update(sql,paperId,studentId);
        return row;
    }
    public int addExamInfo(int paperId,int studentId){
        String sql="INSERT INTO T_EXAM_INFO VALUES (?,?,NULL,DEFAULT ,DEFAULT,'')";
        return update(sql,studentId,paperId);
    }
    public int updateIsTested(ExamInfo e){
        String sql="update t_exam_info set is_tested=? where paper_id=? and student_id=?";
        return update(sql,e.getIsTested(),e.getPaperId(),e.getStudentId());
}
    public int updateIsRead(ExamInfo e){
        String sql="update t_exam_info set is_read=? where paper_id=? and student_id=?";
        return update(sql,e.getIsRead(),e.getPaperId(),e.getStudentId());
    }
    public int updateReadName(ExamInfo e){
        String sql="update t_exam_info set read_name=? where paper_id=? and student_id=?";
        return update(sql,e.getTeacherName(),e.getPaperId(),e.getStudentId());
    }
    public int updateRocord(ExamInfo e){
        String sql="update t_exam_info set rocord=? where paper_id=? and student_id=?";
        return update(sql,e.getRocord(),e.getPaperId(),e.getStudentId());
    }
    public List<ExamInfo> findExamByInfo(ExamInfo e){
        StringBuffer sb=new StringBuffer();
        sb.append("select e.*,USER_NAME FROM(select c.*,paper_name,START_TIME,PAPER_TIME from T_EXAM_INFO c inner join T_PAPER_INFO d on c.PAPER_ID=d.PAPER_ID)e INNER JOIN TB_USER f ON e.STUDENT_ID=f.USER_ID where student_id=? AND is_tested=0");
        if (e!=null){
            if (e.getPaperName()!=null){
                sb.append("  and paper_name like '%"+e.getPaperName()+"%'");
            }
        }
        ResultSet set=select(sb.toString(),e.getStudentId());
        List<ExamInfo> list=new ArrayList<>();
        try {
            while (set.next()){
                ExamInfo examInfo=new ExamInfo();
                examInfo.setPaperName(set.getString("paper_name"));
                examInfo.setStartTime(set.getTimestamp("start_time"));
                examInfo.setPaperTime(set.getInt("paper_time"));
                examInfo.setPaperId(set.getInt("paper_id"));
                list.add(examInfo);
            }
        } catch (SQLException e1) {
            e1.printStackTrace();
        }
        return list;
    }
}
