package dao;

import pojo.Note;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class NoteDao extends BaseDao {

    //总记录数
    public List<Note> findNote() {
       ResultSet set=select("select * from tb_file");
       List<Note> list=new ArrayList<>();
        try {
            while (set.next()) {
                Note n = new Note();
                n.setFileId(set.getInt("file_id"));
                n.setFileTitle(set.getString("file_title"));
                n.setFileContent(set.getString("file_content"));
                n.setReleaseTime(set.getTimestamp("release_time"));
                n.setUserId(set.getInt("user_id"));
                n.setVisible(set.getInt("visible"));
                list.add(n);
            }
            closeAll();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    /**
     * 查询
     * @return
     */
    public List<Note> findFile() {
        ResultSet set = select("select * from tb_file order by release_time desc");
        List<Note> list = new ArrayList<>();
        try {
            while (set.next()) {
                Note n = new Note();
                n.setFileId(set.getInt("file_id"));
                n.setFileTitle(set.getString("file_title"));
                n.setFileContent(set.getString("file_content"));
                n.setUserId(set.getInt("user_id"));
                n.setReleaseTime(set.getTimestamp("release_time"));
                n.setVisible(set.getInt("visible"));
                list.add(n);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }
    /**
     * 删除
     *
     * @param fileId
     * @return
     */
    public int delete(int fileId) {
        String sql = "delete from tb_file where file_id=?";
        int row = update(sql, fileId);
        return row;
    }

    /**
     * 增
     *
     * @param file
     * @return
     */
    public int addFile(Note file) {
        String sql = "insert into tb_file values(seq_tb_file.nextval,?,?,1,sysdate,0)";
        int row = update(sql, file.getFileTitle(), file.getFileContent());
        return row;
    }

    /**
     * 是否公开
     * @return
     */
    public List<Note> visibleFile(Note visiBle){
        String sql="select * from tb_file where visible=?";
//        int row=update(sql)
        ResultSet set=select(sql,visiBle.getVisible());
        List<Note> list=new ArrayList<>();
        try {
            while(set.next()){
                Note f=new Note();
                f.setFileId(set.getInt("file_id"));
                f.setFileTitle(set.getString("file_title"));
                f.setFileContent(set.getString("file_content"));
                f.setUserId(set.getInt("user_id"));
                f.setReleaseTime(set.getTimestamp("release_time"));
                f.setVisible(set.getInt("visible"));
                list.add(f);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

}