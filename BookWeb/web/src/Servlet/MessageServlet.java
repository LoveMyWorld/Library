package Servlet;

import Entity.Message;

import Service.MessageService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;


@WebServlet(name = "MessageServlet", value = "/MessageServlet") public class MessageServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        //获取数据
        //取最近的十条消息
        MessageService messageService = new MessageService();




        List<Message> list =messageService.getAllData();


        //将数据投送到表格中


        request.setAttribute("massagelist", list);

        request.getRequestDispatcher("/wangye/managemessage.jsp").forward(request, response);



    }


}
