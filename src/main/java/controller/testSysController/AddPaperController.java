package controller.testSysController;

import dao.ExamInfoDao;
import dao.UserDao;
import dao.testSysDao.PaperInfoDao;
import dao.testSysDao.PaperQueDao;
import dao.testSysDao.QuestionsDao;
import pojo.User;
import pojo.testSys.PaperInfo;
import pojo.testSys.Questions;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.List;

@WebServlet(name = "AddPaperController",urlPatterns = "/addPaper.html")
public class AddPaperController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        RequestDispatcher rd = req.getRequestDispatcher("/pages/testSystem/addPaper.jsp");
        rd.forward(req,resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("utf-8");
        String paperName=req.getParameter("paperName");
        String startTime=req.getParameter("startTime");
        String paperTime=req.getParameter("paperTime");
        String userName=req.getParameter("userName");
        String endTime=req.getParameter("endTime");
        String sinChoice=req.getParameter("sinChoice");
        String sinScore=req.getParameter("sinScore");
        String mulChoice=req.getParameter("mulChoice");
        String mulScore=req.getParameter("mulScore");
        String judge=req.getParameter("judge");
        String judScore=req.getParameter("judScore");
        String answer=req.getParameter("answer");
        String ansScore=req.getParameter("ansScore");
        PaperInfo pi=new PaperInfo();
        pi.setPaperName(paperName);
        pi.setUserName(userName);
        pi.setPaperTime(Integer.valueOf(paperTime));
        if(startTime!=null && endTime!=null ){
            try {
                SimpleDateFormat fmt=new SimpleDateFormat("yyyy-MM-dd");
                pi.setStartTime(fmt.parse(startTime));
                pi.setEndTime(fmt.parse(endTime));
            } catch (ParseException e) {
                e.printStackTrace();
            }
        }
        pi.setScore(Integer.valueOf(sinChoice)*Integer.valueOf(sinScore)+Integer.valueOf(mulChoice)*Integer.valueOf(mulScore)+Integer.valueOf(judge)*Integer.valueOf(judScore)+Integer.valueOf(answer)*Integer.valueOf(ansScore));
        PaperInfoDao dao=new PaperInfoDao();
        int row=dao.addPaper(pi);
        int id=dao.findPaperId(paperName);
        QuestionsDao dao1=new QuestionsDao();
        PaperQueDao dao3=new PaperQueDao();
        List<Questions> list=dao1.findQuestion(1,Integer.valueOf(sinChoice));
        List<Questions> list2=dao1.findQuestion(2,Integer.valueOf(mulChoice));
        List<Questions> list3=dao1.findQuestion(3,Integer.valueOf(judge));
        List<Questions> list4=dao1.findQuestion(4,Integer.valueOf(answer));
        for (Questions qid:list ) {
            dao3.addPaperQue(id,qid.getQuestionId());
        }
        for (Questions qid2:list2 ) {
            dao3.addPaperQue(id,qid2.getQuestionId());
        }
        for (Questions qid3:list3 ) {
            dao3.addPaperQue(id,qid3.getQuestionId());
        }
        for (Questions qid4:list4 ) {
            dao3.addPaperQue(id,qid4.getQuestionId());
        }
        UserDao userdao=new UserDao();
        ExamInfoDao Edao=new ExamInfoDao();
        List<User> userlist=userdao.findUser();
        for (User uList:userlist) {
            Edao.addExamInfo(id,uList.getUserId());
        }
        if(row>0){
            resp.sendRedirect("/paper.html");
        }else {
            req.getSession().setAttribute("msg","发布失败");
            resp.sendRedirect("/addPaper.html");
        }
    }
}
