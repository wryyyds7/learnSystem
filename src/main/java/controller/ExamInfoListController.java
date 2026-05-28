package controller;

import dao.ExamInfoDao;
import pojo.ExamInfo;
import pojo.Page;
import pojo.Question;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "ExamInfoListController",urlPatterns = "/examInfoList.html")
public class ExamInfoListController extends HttpServlet{
    Page<ExamInfo> page=new Page<>();
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        //super.doGet(req, resp);
        req.setCharacterEncoding("utf-8");
        ExamInfoDao examInfoDao=new ExamInfoDao();
        String currentPage=req.getParameter("currentPage");
        if(currentPage!=""){
            page.setCurrentPage(currentPage);
        }
        if(page.getTotal()==null&&page.getCondition()==null){
            ExamInfo ex=new ExamInfo();
            page.setTotal(examInfoDao.countExamInfoPage(ex));
        }
        page.setList(examInfoDao.findExamInfoByPage(page));
        req.setAttribute("p",page);
        req.getRequestDispatcher("/pages/exam/exam_list.jsp").forward(req,resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        //super.doPost(req, resp);
        ExamInfo e=new ExamInfo();
        String paperName=req.getParameter("paperName");
        String studentName=req.getParameter("studentName");
        String isTested=req.getParameter("isTested");
        String isRead=req.getParameter("isRead");
        ExamInfoDao examInfoDao=new ExamInfoDao();
        if (paperName!=null&&paperName.length()>0){
            e.setPaperName(paperName);
        }
        if (studentName!=null&&studentName.length()>0){
            e.setStudentName(studentName);
        }
        if (isTested!=null&&isTested.length()>0){
            e.setIsTested(Integer.valueOf(isTested));
        }
        if (isRead!=null&&isRead.length()>0){
            e.setIsRead(Integer.valueOf(isRead));
        }
        page.setCondition(e);
        page.setTotal(examInfoDao.countExamInfoPage(e));
        this.doGet(req,resp);
    }
}
