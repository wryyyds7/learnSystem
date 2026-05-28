package controller;

import dao.TopicDao;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "TopicDeleteController",urlPatterns = "/admin/topic/del")
public class TopicDeleteController extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        TopicDao dao=new TopicDao();
        String topicId=request.getParameter("topicId");
        if (topicId!=null){
            dao.delTopic(Integer.valueOf(topicId));
        }
    }
}
