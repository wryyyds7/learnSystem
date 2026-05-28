package controller;

import com.alibaba.fastjson.JSON;
import dao.BoardDao;
import dao.TopicBackDao;
import dao.TopicDao;
import pojo.*;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "DetailController", urlPatterns = "/forum/detail")
public class DetailController extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//        HttpSession session = request.getSession();
        request.setCharacterEncoding("utf-8");
        response.setCharacterEncoding("utf-8");
        String tid = request.getParameter("tid");
        TopicDao topicDao = new TopicDao();
        if (tid != null && tid.length() > 0) {
            Topic topic = topicDao.findTopicByTid(tid);
            request.setAttribute("topic", topic);
            TopicBack topicBack = new TopicBack();
            Page<TopicBack> page = new Page<>();
            String currPage = request.getParameter("currPage");
            if (currPage == null) {
                currPage = "1";
            }
            topicBack.setTopicId(topic.getTopicId());
            page.setCondition(topicBack);
            page.setPageSize(6);
            page.setCurrentPage(currPage);
            page = new TopicBackDao().findTopicBackByPage(page);
            request.setAttribute("page", page);
            List<Board> blist = new BoardDao().findBoard();
            request.setAttribute("boardList", blist);
        }
        RequestDispatcher rd = request.getRequestDispatcher("/pages/forum/detail.jsp");
        rd.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User user = (User) request.getSession().getAttribute("user_info");
        String tid = request.getParameter("tid");
        String content = request.getParameter("content");
        if (content != "" && tid != null && tid.length() > 0 && user != null) {
            TopicBack topicBack = new TopicBack();
            topicBack.setContent(request.getParameter("content"));
            topicBack.setTopicId(Integer.valueOf(tid));
            topicBack.setUserId(user.getUserId());
            new TopicBackDao().addTopicBack(user, topicBack);
        }
        TopicDao topicDao = new TopicDao();

        String type = request.getParameter("type");
        if (type != null && type.length() > 0) {
            switch (type) {
                case "del":
                    topicDao.delTopic(Integer.valueOf(tid));
                    break;
                case "top":
                    topicDao.top(tid);
                    break;
                case "detop":
                    topicDao.detop(tid);
                    break;
                case "hl":
                    topicDao.highlight(tid);
                    break;
                case "dehl":
                    topicDao.dehighlight(tid);
                    break;
            }
        }
    }
}
