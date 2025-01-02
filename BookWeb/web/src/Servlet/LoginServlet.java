package Servlet;

import Entity.User;
import Service.LoginService;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet( name = "loginServlet" , value = "/loginServlet")
public class LoginServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        // 获取数据
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        User user = new User(username, password);

        // 处理数据
        LoginService loginService = new LoginService();
        String ok = loginService.isCorrect(user);
        if(ok.equals("true")){
            request.getRequestDispatcher("index.jsp").forward(request, response);
        }
        else{
            request.setAttribute("login_ret" , ok);
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}
