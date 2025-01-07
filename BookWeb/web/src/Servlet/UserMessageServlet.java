package Servlet;

import Entity.Message;
import Service.MessageService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.time.LocalDate;


@WebServlet( name = "UserMessageServlet" , value = "/UserMessageServlet")
public class UserMessageServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        // 获取数据
        String publisher = request.getParameter("publisher");

        String messageText = request.getParameter("messageText");

        //处理数据


        //取最后一条数据的id，得到当前的id
        MessageService messageService = new MessageService();

        int id = messageService.maxID();
        id ++;



        //写入数据库
        Message message = new Message(id,publisher,messageText);



        messageService.addLine(message);

        request.getRequestDispatcher("/wangyeyonghu/message.jsp").forward(request, response);



    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}

