package controller;

import dao.ExamInfoDao;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "ExamDelController",urlPatterns = "/examDel.html")
public class ExamDelController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("utf-8");
        String paperId=req.getParameter("paperId");
        String studentId=req.getParameter("studentId");
        if (paperId!=null&&paperId.length()>0&&studentId!=null&&studentId.length()>0){
            ExamInfoDao examInfoDao=new ExamInfoDao();
            examInfoDao.del(Integer.valueOf(paperId),Integer.valueOf(studentId));
        }
    }
}
