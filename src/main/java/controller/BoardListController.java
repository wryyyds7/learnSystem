package controller;

import dao.BaseDao;
import dao.BoardDao;
import dao.UserDao;
import pojo.Board;
import pojo.Page;
import pojo.User;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "BoardListController", urlPatterns = "/admin/board/list")
public class BoardListController extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//        BoardDao dao = new BoardDao();
//        List<Board> list = dao.findBoard();
//        request.setAttribute("list", list);
//        request.setAttribute("count", dao.getCount());
        request.setCharacterEncoding("utf-8");
        BoardDao dao = new BoardDao();
        //分页查询
        Page<Board> page=new Page<>();
        page.setCurrentPage(request.getParameter("currentPage"));
        //其他条件
        Board n=new Board();
        String boardName=request.getParameter("boardName");
        if (boardName!=null&&boardName.length()>0){
            n.setBoardName(boardName);
        }
        page.setCondition(n);
        page.setTotal((long)dao.getCount());
        page=dao.findBoardByPage(page);
        request.setAttribute("p",page);
        request.setAttribute("count",dao.getCount());
        RequestDispatcher rd = request.getRequestDispatcher("/pages/admin/board_list.jsp");
        rd.forward(request, response);
    }
}
