package controller;

import dao.TopicBackDao;
import dao.TopicDao;
import pojo.Topic;
import pojo.TopicBack;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "MyPostController", urlPatterns = "/forum/myPost")
public class MyPostController extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        TopicDao topicDao = new TopicDao();
        String tid = request.getParameter("tid");
        if (tid != null && tid.length() > 0) {
            topicDao.delTopic(Integer.valueOf(tid));
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        TopicDao topicDao = new TopicDao();
        String uid = request.getParameter("uid");
        if (uid != null && uid.length() > 0) {
            List<Topic> list = topicDao.findTopicByUid(uid);
            request.setAttribute("list", list);
        }
        RequestDispatcher rd = request.getRequestDispatcher("/pages/forum/mypost.jsp");
        rd.forward(request, response);
    }

}
