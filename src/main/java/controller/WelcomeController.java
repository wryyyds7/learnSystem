package controller;

import dao.TopicBackDao;
import dao.TopicDao;
import dao.UserDao;
import pojo.User;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "WelcomeController",urlPatterns = "/admin/welcome")
public class WelcomeController extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//        String userCount = request.getParameter("");
        request.setAttribute("userCount",new UserDao().getCount());
        request.setAttribute("topicCount",new TopicDao().getCount());
        request.setAttribute("topicBackCount",new TopicBackDao().getCount());
        RequestDispatcher rd = request.getRequestDispatcher("/pages/admin/welcome.jsp");
        rd.forward(request,response);
    }
}
