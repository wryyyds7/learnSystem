package controller;

import dao.BoardDao;
import dao.TopicDao;
import pojo.Board;
import pojo.Topic;
import pojo.User;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "TopicAddController", urlPatterns = "/forum/addTopic")
public class TopicAddController extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user_info");
        if (user != null &&request.getParameter("content")!="") {
            Topic topic = new Topic();
            topic.setBoardId(Integer.valueOf(request.getParameter("bid")));
            topic.setUserId(user.getUserId());
            topic.setTitle(request.getParameter("title"));
            topic.setContent(request.getParameter("content"));
            topic.setPicture("");
            new TopicDao().addTopic(topic, user);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Board> blist = new BoardDao().findBoard();
        request.setAttribute("boardList",blist);
        RequestDispatcher rd = request.getRequestDispatcher("/pages/forum/add.jsp");
        rd.forward(request, response);
    }
}
