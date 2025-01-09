
package Servlet;


import Entity.Tongbao;
import Service.TongbaoService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.time.LocalDate;


@WebServlet( name = "TongbaoServlet" , value = "/TongbaoServlet")
public class TongbaoServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        // 获取数据
        String publisher = request.getParameter("publisher");
        String announcementKey = request.getParameter("announcementKey");
        Object o =  request.getParameter("announcementDate");
        LocalDate announcementDate = LocalDate.parse(request.getParameter("announcementDate"));
        String announcementText = request.getParameter("announcementText");

        //处理数据







        //取最后一条数据的id，得到当前的id
        TongbaoService announcementService = new TongbaoService();

        int id = announcementService.maxID();
        id ++;



        //写入数据库
        Tongbao announcement = new Tongbao(id,announcementDate,publisher,announcementText,announcementKey);



        announcementService.addLine(announcement);

        request.getRequestDispatcher("/wangye/network.jsp").forward(request, response);



    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}



