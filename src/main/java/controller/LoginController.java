package controller;

import com.alibaba.fastjson.JSON;
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
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Map;


@WebServlet(name = "LoginController", urlPatterns = "/login")
public class LoginController extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        session.removeAttribute("user_info");
        UserDao userDao = new UserDao();
        User user = userDao.login(request.getParameter("username"), request.getParameter("password"));
        PrintWriter out = response.getWriter();
        Map map = new HashMap();
        if (user != null) {
            session.setAttribute("user_info", user);
            map.put("msg", true);
        }else{
            map.put("msg", false);
        }
        out.print(JSON.toJSONString(map));
        out.close();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        RequestDispatcher rd = request.getRequestDispatcher("/pages/user/login.jsp");
        rd.forward(request, response);
    }
}
