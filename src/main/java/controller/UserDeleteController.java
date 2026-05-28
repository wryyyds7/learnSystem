package controller;

import dao.UserDao;
import pojo.User;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;

@WebServlet(name = "UserDeleteController", urlPatterns = "/admin/delUser")
public class UserDeleteController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String uid = request.getParameter("uid");
        if (uid!=null&&uid.length()>0){
            new UserDao().delUser(Integer.valueOf(uid));
        }
        RequestDispatcher rd = request.getRequestDispatcher("/pages/user/update.jsp");
        rd.forward(request,response);
    }

}
