package controller;

import dao.AnswerDao;
import dao.ChoseDao;
import dao.QuestionDao;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "QuestionDelController",urlPatterns = "/questionDel.html")
public class QuestionDelController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        //super.doGet(req, resp);

    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        //super.doPost(req, resp);
        String questionId=req.getParameter("quId");
        if (questionId!=null&&questionId.length()>0){
            QuestionDao questionDao=new QuestionDao();
            AnswerDao answerDao=new AnswerDao();
            ChoseDao choseDao=new ChoseDao();
            questionDao.del(Integer.valueOf(questionId));
            answerDao.del(Integer.valueOf(questionId));
            choseDao.del(Integer.valueOf(questionId));
        }
    }
}
