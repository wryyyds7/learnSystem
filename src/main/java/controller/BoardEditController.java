package controller;

import dao.BoardDao;
import pojo.Board;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "BoardEditController",urlPatterns = "/admin/board/edit")
public class BoardEditController extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Board b = new Board();
        BoardDao dao = new BoardDao();
        request.setCharacterEncoding("utf-8");
        String boardId = request.getParameter("boardId");
        String boardName = request.getParameter("boardName");
        String userId = request.getParameter("userId");
        request.setAttribute("ud",userId);
        b.setBoardName(boardName);
        b.setUserId(Integer.valueOf(userId));
        b.setBoardId(Integer.valueOf(boardId));
        request.setAttribute("b",b);
        int row = dao.updateBoard(b);
        if (row>0) {
            response.getWriter().print("1");
        }else {
            response.getWriter().print("0");

        }

    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        BoardDao dao = new BoardDao();
        List<Board> list = dao.findBoard();
        request.setAttribute("list",list);
        String boardId = request.getParameter("boardId");

        if(boardId!=null&&boardId.length()>0){
            Board b =dao.findBordById(Integer.valueOf(boardId));
            request.setAttribute("b",b);
        }
        request.getRequestDispatcher("/pages/admin/board_edit.jsp").forward(request, response);
    }
}
