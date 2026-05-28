package controller;

import com.alibaba.fastjson.JSONObject;
import dao.BoardDao;
import dao.TopicDao;
import dao.UserDao;
import pojo.Board;
import pojo.Page;
import pojo.Topic;
import pojo.User;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.*;

@WebServlet(name = "ForumController", urlPatterns = "/forum")
public class ForumController extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");
        response.setCharacterEncoding("utf-8");
        HttpSession session  = request.getSession();
        String type = request.getParameter("type");
        int sort = 1;
        if (type!=null&&type.length()>0){
            switch (type){
                case "new":
                    sort = 1;
                    break;
                case "reply":
                    sort = 2;
                    break;
            }
        }
        String bid = (String)session.getAttribute("bid");
        if (bid==null){
            bid = "1";
            session.removeAttribute("bid");
        }
        String currPage = request.getParameter("page");
        Map<String,Object> map = new HashMap();
        Page<Topic> page = new Page<>();
        page.setPageSize(6);
        page.setCurrentPage(currPage);
        page = new TopicDao().findTopicByPage(page,Integer.valueOf(bid),sort,0);
        map.put("currList",page.getList());
        map.put("totel",6);
        map.put("totelPage",page.getTotalPage());
        response.getWriter().print(new JSONObject(map));
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String bid = request.getParameter("bid");
        HttpSession session = request.getSession();
        if(bid!=null&&bid.length()>0){
            session.setAttribute("bid",bid);
        }else{
            session.setAttribute("bid","1");
        }
        List<Topic> list = new TopicDao().findTopic();
        request.setAttribute("topicList",list);
        List<User> ulist = new UserDao().findUser();
        request.setAttribute("userList",ulist);
        List<Board> blist = new BoardDao().findBoard();
        request.setAttribute("boardList",blist);
        RequestDispatcher rd = request.getRequestDispatcher("/pages/forum/index.jsp");
        rd.forward(request,response);
    }
}
