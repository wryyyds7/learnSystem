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
import java.util.List;

@WebServlet(name = "UserListController", urlPatterns = "/admin/user/list")
public class UserListController extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        UserDao dao = new UserDao();
        List<User> list = dao.findUser();
        request.setAttribute("list", list);
        request.setAttribute("count", dao.getCount());
        RequestDispatcher rd = request.getRequestDispatcher("/pages/admin/user_list.jsp");
        rd.forward(request, response);
    }
}
