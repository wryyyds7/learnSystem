package controller;

import dao.AnswerDao;
import dao.ChoseDao;
import dao.QuestionDao;
import dao.TypeDao;
import pojo.Answer;
import pojo.Chose;
import pojo.Question;
import pojo.Type;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "QuestionUpdateController",urlPatterns = "/questionUpdate.html")
public class QuestionUpdateController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        //super.doGet(req, resp);
        req.setCharacterEncoding("utf-8");
        TypeDao dao=new TypeDao();
        List<Type> list=dao.findType();
        req.setAttribute("list",list);
        String questionId=req.getParameter("quId");
        QuestionDao questionDao=new QuestionDao();
        AnswerDao answerDao=new AnswerDao();
        ChoseDao choseDao=new ChoseDao();
        if (questionId!=null&&questionId.length()>0){
            Question q=questionDao.findQuestionById(Integer.valueOf(questionId));
            List<Chose> list1=null;
            List<Answer> list2=null;
            if (q.getTypeId()==1||q.getTypeId()==2){
                list1=choseDao.findChoseById(Integer.valueOf(questionId));
            }
            if(q.getTypeId()!=4){
                list2=answerDao.findAnswerById(Integer.valueOf(questionId));
            }
            req.setAttribute("list1",list1);
            req.setAttribute("list2",list2);
            req.setAttribute("ques",q);
        }
        req.getRequestDispatcher("/pages/question/questionUpdate.jsp").forward(req,resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("utf-8");
        String type=req.getParameter("type1");
        String questionId=req.getParameter("questionId");
        String questionContent=req.getParameter("question");
        if(questionId!=null){
            if (Integer.valueOf(type)==1){
                String choseA=req.getParameter("chose1");
                String choseB=req.getParameter("chose2");
                String choseC=req.getParameter("chose3");
                String choseD=req.getParameter("chose4");
                String chose=req.getParameter("choseRo");
                QuestionDao questionDao=new QuestionDao();
                Question q=new Question();
                q.setQuestion(questionContent);
                q.setQuestionId(Integer.valueOf(questionId));
                int count1=questionDao.update(q);
                if(count1>0){
                    ChoseDao choseDao=new ChoseDao();
                    Chose c=new Chose();
                    c.setQuestionId(Integer.valueOf(questionId));
                    c.setChoseId("A");
                    c.setChose(choseA);
                    choseDao.update(c);
                    c.setChoseId("B");
                    c.setChose(choseB);
                    choseDao.update(c);
                    c.setChoseId("C");
                    c.setChose(choseC);
                    choseDao.update(c);
                    c.setChoseId("D");
                    c.setChose(choseD);
                    choseDao.update(c);
                    Answer answer=new Answer();
                    answer.setQuestionId(Integer.valueOf(questionId));
                    answer.setAnswer(chose);
                    AnswerDao answerDao=new AnswerDao();
                    answerDao.del(Integer.valueOf(questionId));
                    answerDao.addAnswer(answer);
                }
            }else if (Integer.valueOf(type)==2){
                String choseA=req.getParameter("chose1");
                String choseB=req.getParameter("chose2");
                String choseC=req.getParameter("chose3");
                String choseD=req.getParameter("chose4");
                String[] chose=req.getParameterValues("choseChe");
                QuestionDao questionDao=new QuestionDao();
                Question q=new Question();
                q.setQuestion(questionContent);
                q.setQuestionId(Integer.valueOf(questionId));
                int count=questionDao.update(q);
                if (count>0){
                    ChoseDao choseDao=new ChoseDao();
                    Chose c=new Chose();
                    c.setQuestionId(Integer.valueOf(questionId));
                    c.setChoseId("A");
                    c.setChose(choseA);
                    choseDao.update(c);
                    c.setChoseId("B");
                    c.setChose(choseB);
                    choseDao.update(c);
                    c.setChoseId("C");
                    c.setChose(choseC);
                    choseDao.update(c);
                    c.setChoseId("D");
                    c.setChose(choseD);
                    choseDao.update(c);
                    AnswerDao answerDao=new AnswerDao();
                    answerDao.del(Integer.valueOf(questionId));
                    if(chose!=null){
                        for (int i=0;i<chose.length;i++){
                            Answer answer=new Answer();
                            answer.setQuestionId(Integer.valueOf(questionId));
                            answer.setAnswer(chose[i]);
                            answerDao.addAnswer(answer);
                        }
                    }
                }
            }else if(Integer.valueOf(type)==3){
                String judge=req.getParameter("judge");
                QuestionDao questionDao=new QuestionDao();
                Question q=new Question();
                q.setQuestion(questionContent);
                q.setQuestionId(Integer.valueOf(questionId));
                int count=questionDao.update(q);
                if (count>0){
                    Answer answer=new Answer();
                    answer.setQuestionId(Integer.valueOf(questionId));
                    answer.setAnswer(judge);
                    AnswerDao answerDao=new AnswerDao();
                    answerDao.del(Integer.valueOf(questionId));
                    answerDao.addAnswer(answer);
                }
            }else if (Integer.valueOf(type)==4){
                QuestionDao questionDao=new QuestionDao();
                Question q=new Question();
                q.setQuestion(questionContent);
                q.setQuestionId(Integer.valueOf(questionId));
                int count=questionDao.update(q);
            }
        }
    }
}
