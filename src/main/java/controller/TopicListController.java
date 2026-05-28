package controller;

import dao.BoardDao;
import dao.TopicDao;
import pojo.Page;
import pojo.Topic;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "TopicListController", urlPatterns = "/admin/topic/list")
public class TopicListController extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");
        TopicDao dao = new TopicDao();
        Page<Topic> page=new Page<>();
        page.setCurrentPage(request.getParameter("currentPage"));
        Topic topic=new Topic();
        String title=request.getParameter("title");
        if (title!=null&&title.length()>0){
            topic.setTitle(title);
        }
        page.setCondition(topic);
        page.setTotal((long)dao.getCount());
        page=dao.findTopicByPage(page);
        request.setAttribute("p",page);
        request.setAttribute("board",new BoardDao().findBoard());
        request.setAttribute("count",dao.getCount());
        request.getRequestDispatcher("/pages/admin/topic_list.jsp").forward(request,response);
    }

}
