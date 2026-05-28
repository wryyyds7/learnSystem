package controller;

import dao.QuestionDao;
import dao.TypeDao;
import pojo.Page;
import pojo.Question;
import pojo.Type;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
@WebServlet(name = "QuestionListController",urlPatterns = "/questionList.html")
public class QuestionListController extends HttpServlet {
    Page<Question> page=new Page<>();
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        //super.doGet(req, resp);
        req.setCharacterEncoding("utf-8");
        TypeDao dao=new TypeDao();
        List<Type> list=dao.findType();
        req.setAttribute("list",list);
        QuestionDao questionDao=new QuestionDao();
        String currentPage=req.getParameter("currentPage");
        if(currentPage!=""){
            page.setCurrentPage(currentPage);
        }
        if(page.getTotal()==null&&page.getCondition()==null){
            Question q=new Question();
            page.setTotal(questionDao.countQuestionPage(q));
        }
        page.setList(questionDao.findQuestionByPage(page));
        req.setAttribute("p",page);

        req.getRequestDispatcher("/pages/question/questionList.jsp").forward(req,resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        //super.doPost(req, resp);
        req.setCharacterEncoding("utf-8");
        String startTime=req.getParameter("start");
        String endTime=req.getParameter("end");
        String question=req.getParameter("question");
        String type1=req.getParameter("type1");
        QuestionDao questionDao=new QuestionDao();
        Question qu=new Question();
        if(startTime!=null&&startTime.length()>0){
            qu.setStartTime(startTime);
        }
        if(endTime!=null&&endTime.length()>0){
            qu.setEndTime(endTime);
        }
        if (question!=null&&question.length()>0){
            qu.setQuestion(question);
        }
        if (type1!=null&&type1.length()>0){
            qu.setTypeId(Integer.valueOf(type1));
        }
        page.setTotal(questionDao.countQuestionPage(qu));
        page.setCondition(qu);
        this.doGet(req,resp);
    }
}
