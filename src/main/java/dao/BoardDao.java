package dao;

import pojo.Board;
import pojo.Page;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class BoardDao extends BaseDao {
    public List<Board> findBoard(){
        ResultSet set=select("select a.*,user_name from tb_board a join tb_user b on a.user_id=b.user_id order by board_id");
        List<Board> list=new ArrayList<>();
        try {
            while (set.next()){
                Board board=new Board();
                board.setBoardId(set.getInt("board_id"));
                board.setBoardName(set.getString("board_name"));
                board.setUserId(set.getInt("user_id"));
                board.setUserName(set.getString("user_name"));
                list.add(board);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }
    public int delBoard(int board_id){
        String sql="delete from tb_board where board_id=?";
        return  update(sql,board_id);

    }
    public int addBoard(Board board) {
        String sql = "insert into tb_board values(seq_tb_topic.nextval,?,?)";
        int row = update(sql, board.getBoardName(), board.getUserId());
        return row;
    }

    public int updateBoard(Board board){
        String sql = "update tb_board set board_name=?,user_id=? where board_Id=?";
        return update(sql, board.getBoardName(), board.getUserId(), board.getBoardId());
    }

    public Page findBoardByPage(Page<Board> page) {
        if (page != null) {
            StringBuffer sb = new StringBuffer();
            sb.append(Page.PAGE_START);
            sb.append("select * from TB_board a left join tb_user b on a.user_id=b.user_id where 1=1 ");
            Board con = page.getCondition();
            if (con != null) {
                if (con.getBoardName() != null && con.getBoardName().length() > 0) {
                    sb.append("  and board_Name like '%" + con.getBoardName() + "%'");

                }
//                if (con.getBoardId() > 0) {
//                    sb.append("  and a.board_Id=" + con.getBoardId());
//                }
            }
            sb.append("  order by board_id desc");
            sb.append(Page.PAGE_END);
            ResultSet set = select(sb.toString(), page.getEnd(), page.getStart());
            List<Board> list = new ArrayList<>();
            try {
                while (set.next()) {
                    Board board = new Board();
                    board.setBoardId(set.getInt("board_id"));
                    board.setBoardName(set.getString("board_name"));
                    board.setUserId(set.getInt("user_Id"));
                    board.setUserName(set.getString("user_name"));
                    list.add(board);
                }
                page.setList(list);
                return page;
            } catch (Exception e) {
                e.printStackTrace();
            }
        }


        return null;
    }
    public Board findBordById(int boardId){
        String sql="select * from tb_board where board_Id=?";
        ResultSet set=select(sql,boardId);
        try {
            while (set.next()){
                Board t=new Board();
                t.setBoardName(set.getString("board_name"));
                t.setBoardId(set.getInt("board_id"));
                return t;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public int getCount() {
        String sql = "select count(*) from tb_board";
        ResultSet rs = select(sql);
        try {
            while (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }
}
