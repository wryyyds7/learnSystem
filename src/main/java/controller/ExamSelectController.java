package controller;

import dao.ExamInfoDao;
import pojo.ExamInfo;
import pojo.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "ExamSelectController",urlPatterns = "/examSelect.html")
public class ExamSelectController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("utf-8");
        ExamInfoDao examInfoDao=new ExamInfoDao();
        String paperName=req.getParameter("paperName");
        ExamInfo examInfo=new ExamInfo();
        if (paperName!=null&&paperName.length()>0){
            examInfo.setPaperName(paperName);
        }
        HttpSession session = req.getSession();
        User user = (User)session.getAttribute("user_info");
        if(user!=null){
            examInfo.setStudentId(user.getUserId());
        }else{
            examInfo.setStudentId(1);
        }
        List<ExamInfo> list=examInfoDao.findExamByInfo(examInfo);
        req.setAttribute("list",list);
        req.setAttribute("ex",examInfo);
        req.getRequestDispatcher("/pages/exam/exam.jsp").forward(req,resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        //super.doPost(req, resp);
        this.doGet(req,resp);
    }
}
