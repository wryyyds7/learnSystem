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

@WebServlet(name = "RegisterController",urlPatterns = "/register")
public class RegisterController extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");
        UserDao userDao = new UserDao();
        User user = new User();
        user.setUserName(request.getParameter("username"));
        user.setUserPwd(request.getParameter("pass"));
        user.setTel(request.getParameter("phone"));
        if(userDao.addUser(user)>0){
            request.setAttribute("msg","success");
        }else{
            request.setAttribute("msg","failed");
        }
        this.doGet(request, response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        RequestDispatcher rd = request.getRequestDispatcher("/pages/user/register.jsp");
        rd.forward(request,response);
    }
}
