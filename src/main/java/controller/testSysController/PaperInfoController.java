package controller.testSysController;

import dao.testSysDao.PaperInfoDao;
import pojo.Page;
import pojo.testSys.PaperInfo;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;


@WebServlet(name = "PaperInfoController",urlPatterns = "/paper.html")
public class PaperInfoController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("utf-8");
        PaperInfoDao dao=new PaperInfoDao();
        PaperInfo p=new PaperInfo();
        Page<PaperInfo> page=new Page<>();
        page.setCurrentPage(req.getParameter("currentPage"));
        String paperName=req.getParameter("paperName");
        if(paperName!=null){
            p.setPaperName(paperName);
            page.setCondition(p);
        }
        page.setCondition(p);
        page.setPageSize(3);
        page=dao.findPaperByPage(page);
        req.setAttribute("p",page);
        RequestDispatcher rd = req.getRequestDispatcher("/pages/testSystem/paperList.jsp");
        rd.forward(req,resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        this.doGet(req,resp);
    }
}
