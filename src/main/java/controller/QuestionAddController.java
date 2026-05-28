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
import java.util.List;

@WebServlet(name = "QuestionAddController",urlPatterns = "/questionAdd.html")
public class QuestionAddController extends HttpServlet{
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        //super.doGet(req, resp);
        req.setCharacterEncoding("utf-8");
        TypeDao dao=new TypeDao();
        List<Type> list=dao.findType();
        req.setAttribute("list",list);
        req.getRequestDispatcher("/pages/question/questionAdd.jsp").forward(req,resp);

    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        //super.doPost(req, resp);
        req.setCharacterEncoding("utf-8");
        String type=req.getParameter("type1");
        String questionContent=req.getParameter("question");
        if(type!=null){
            if (Integer.valueOf(type)==1){
                String choseA=req.getParameter("chose1");
                String choseB=req.getParameter("chose2");
                String choseC=req.getParameter("chose3");
                String choseD=req.getParameter("chose4");
                String chose=req.getParameter("choseRo");
                QuestionDao questionDao=new QuestionDao();
                Question q=new Question();
                q.setQuestion(questionContent);
                q.setTypeId(Integer.valueOf(type));
                int count1=questionDao.addQuestion(q);
                if(count1>0){
                    int id=questionDao.findQuestion(questionContent);
                    ChoseDao choseDao=new ChoseDao();
                    Chose c=new Chose();
                    c.setQuestionId(id);
                    c.setChoseId("A");
                    c.setChose(choseA);
                    choseDao.addChose(c);
                    c.setChoseId("B");
                    c.setChose(choseB);
                    choseDao.addChose(c);
                    c.setChoseId("C");
                    c.setChose(choseC);
                    choseDao.addChose(c);
                    c.setChoseId("D");
                    c.setChose(choseD);
                    choseDao.addChose(c);
                    Answer answer=new Answer();
                    answer.setQuestionId(id);
                    answer.setAnswer(chose);
                    AnswerDao answerDao=new AnswerDao();
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
                q.setTypeId(Integer.valueOf(type));
                int count=questionDao.addQuestion(q);
                if (count>0){
                    int id=questionDao.findQuestion(questionContent);
                    ChoseDao choseDao=new ChoseDao();
                    Chose c=new Chose();
                    c.setQuestionId(id);
                    c.setChoseId("A");
                    c.setChose(choseA);
                    choseDao.addChose(c);
                    c.setChoseId("B");
                    c.setChose(choseB);
                    choseDao.addChose(c);
                    c.setChoseId("C");
                    c.setChose(choseC);
                    choseDao.addChose(c);
                    c.setChoseId("D");
                    c.setChose(choseD);
                    choseDao.addChose(c);
                    AnswerDao answerDao=new AnswerDao();
                    if(chose!=null){
                        for (int i=0;i<chose.length;i++){
                            Answer answer=new Answer();
                            answer.setQuestionId(id);
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
                q.setTypeId(Integer.valueOf(type));
                int count=questionDao.addQuestion(q);
                if (count>0){
                    int id=questionDao.findQuestion(questionContent);
                    Answer answer=new Answer();
                    answer.setQuestionId(id);
                    answer.setAnswer(judge);
                    AnswerDao answerDao=new AnswerDao();
                    answerDao.addAnswer(answer);
                }
            }else if (Integer.valueOf(type)==4){
                QuestionDao questionDao=new QuestionDao();
                Question q=new Question();
                q.setQuestion(questionContent);
                q.setTypeId(Integer.valueOf(type));
                int count=questionDao.addQuestion(q);
            }
        }
    }
}
