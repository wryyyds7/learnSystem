package controller;

import dao.BoardDao;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "BoardDeleteController", urlPatterns = "/admin/board/del")
public class BoardDeleteController extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        BoardDao dao = new BoardDao();
        String boardId = request.getParameter("boardId");
        if (boardId != null) {
            int id = Integer.valueOf(boardId);
            dao.delBoard(id);
        }
        request.getRequestDispatcher("/admin/board/list").forward(request, response);
    }
}
