package Servlet;

import Entity.User;
import Service.LoginService;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.*;

import java.io.IOException;

import jakarta.servlet.annotation.WebServlet;

@WebServlet(name = "RegisterServlet", value = "/RegisterServlet")
public class RegisterServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        // 信息获取
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        User user = new User(username, password);

        // 信息处理
        LoginService loginService = new LoginService();
        String ok = loginService.isCorrect(user);

        // 返回结果
        if(ok.equals("true") ){
            request.getRequestDispatcher("index.jsp").forward(request, response);
        }
        else {
            request.setAttribute("login_ret" , ok);
            response.getWriter().write(ok);
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}
