package controller;

import dao.RoleDao;
import dao.UserDao;
import pojo.Role;
import pojo.User;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "RoleListController", urlPatterns = "/admin/role/list")
public class RoleListController extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        RoleDao dao = new RoleDao();
        List<Role> list = dao.findRole();
        request.setAttribute("list", list);
        request.setAttribute("count", dao.getCount());
        RequestDispatcher rd = request.getRequestDispatcher("/pages/admin/role_list.jsp");
        rd.forward(request, response);
    }
}
