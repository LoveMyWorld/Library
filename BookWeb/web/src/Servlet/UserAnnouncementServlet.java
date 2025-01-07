package Servlet;

import Entity.Announcement;
import Service.HistoryAnnouncementService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet (name = "UserAnnouncementServlet" , value ="/UserAnnouncementServlet" ) public class UserAnnouncementServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        //获取数据
        //取最近的十条消息

        HistoryAnnouncementService historyAnnouncementService = new HistoryAnnouncementService();

        List<Announcement> list = historyAnnouncementService.getLastTenLines();


        //将数据投送到表格中


        request.setAttribute("list", list);

        request.getRequestDispatcher("/wangyeyonghu/userAnnouncement.jsp").forward(request, response);


    }
    }
