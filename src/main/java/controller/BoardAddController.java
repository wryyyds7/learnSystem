package controller;

import dao.BoardDao;
import pojo.Board;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "BoardAddController",urlPatterns = "/admin/board/add")
public class BoardAddController extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        BoardDao dao=new BoardDao();
        request.setCharacterEncoding("utf-8");
        String boardName=request.getParameter("boardName");
        String userId=request.getParameter("userId");
        Board b=new Board();
        b.setBoardName(boardName);
        b.setUserId(Integer.valueOf(userId));
        int row=dao.addBoard(b);
        if (row>0) {
            response.getWriter().print("1");
        }else {
            response.getWriter().print("0");

        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("/pages/admin/board_add.jsp").forward(request,response);
    }
}
