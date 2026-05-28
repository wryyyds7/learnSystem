package controller;

import dao.UserDao;
import pojo.User;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "UserInfoShowController", urlPatterns = "/user/info")
public class UserInfoShowController extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String uid = request.getParameter("uid");
        if(uid!=null&&uid.length()>0){
            User user = new UserDao().findUserById(Integer.valueOf(uid));
            request.setAttribute("info",user);
        }
        RequestDispatcher rd = request.getRequestDispatcher("/pages/user/info.jsp");
        rd.forward(request,response);
    }
}
