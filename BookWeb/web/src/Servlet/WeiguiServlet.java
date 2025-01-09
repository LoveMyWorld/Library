package Servlet;
import Entity.WeiGui;


import Service.WeiguiService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet (name = "WeiguiServlet" , value ="/WeiguiServlet" ) public class WeiguiServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        //获取数据
        //取最近的十条消息

        WeiguiService weiguiService = new WeiguiService();

        List<WeiGui> list = weiguiService.getLastTenLines();


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
