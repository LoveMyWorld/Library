package Servlet;
import Entity.Tongbao;

import Service.UserTongbaoService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet (name = "UserTongbaoServlet" , value ="/UserTongbaoServlet" ) public class UserTongbaoServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        //获取数据
        //取最近的十条消息

        UserTongbaoService historyAnnouncementService = new UserTongbaoService();

        List<Tongbao> list = historyAnnouncementService.getLastTenLines();


        //将数据投送到表格中


        request.setAttribute("list", list);

        request.getRequestDispatcher("/wangyeyonghu/userTongbao.jsp").forward(request, response);


    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        super.doPost(req, resp);

        doGet(req, resp);
    }
}
