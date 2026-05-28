package controller.testSysController;

import dao.testSysDao.PaperInfoDao;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "DelPaperController",urlPatterns = "/delPaper.html")
public class DelPaperController extends HttpServlet{
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        //super.doGet(req, resp);
        PaperInfoDao dao=new PaperInfoDao();
        String paperid=req.getParameter("paperid");
        if(paperid!=null){
            int id=Integer.valueOf(paperid);
            int row=dao.delPaper(id);
            if(row==0){
                req.getSession().setAttribute("msg", "删除失败");
            }
        }
        resp.sendRedirect("/paper.html");
    }
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        //super.doPost(req, resp);
    }
}
