package controller.testSysController;

import dao.testSysDao.PaperInfoDao;
import pojo.testSys.PaperInfo;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;


@WebServlet(name = "UpdatePaperController",urlPatterns = "/updatePaper.html")
public class UpdatePaperController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        PaperInfoDao dao=new PaperInfoDao();
        String paperid=req.getParameter("paperid");
        PaperInfo pa =dao.findPaperInfo(Integer.valueOf(paperid));
        req.setAttribute("pa",pa);
        RequestDispatcher rd = req.getRequestDispatcher("/pages/testSystem/updatePaper.jsp");
        rd.forward(req,resp);
    }
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("utf-8");
        PaperInfoDao dao=new PaperInfoDao();
        PaperInfo pi=new PaperInfo();
        String paperName=req.getParameter("paperName");
        String startTime=req.getParameter("startTime");
        String paperTime=req.getParameter("paperTime");
        String userName=req.getParameter("userName");
        String endTime=req.getParameter("endTime");
        String paperId=req.getParameter("paperid");
        pi.setPaperid(Integer.valueOf(paperId));
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
        int row=dao.update(pi);
        if(row>0){
            resp.sendRedirect("/paper.html");
        }else {
            req.getSession().setAttribute("msg","发布失败");
            resp.sendRedirect("/updatePaper.html");
        }
    }
}
