//
// Source code recreated from a .class file by IntelliJ IDEA
// (powered by FernFlower decompiler)
//

package Servlet;

import Entity.User;
import Service.LoginService;
import Service.RegisterService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;


import java.io.IOException;

@WebServlet(
        name = "RegisterServlet",
        value = {"/RegisterServlet"}
)
public class RegisterServlet extends HttpServlet {
    public RegisterServlet() {
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        User user = new User(username, password);
        RegisterService registerService = new RegisterService();
        String ok = registerService.isCorrect(user);
        if (ok.equals("true")) {
            HttpSession session = request.getSession();
            session.setAttribute("username", username);
            request.getRequestDispatcher("register2.jsp").forward(request, response);
        } else {
            request.setAttribute("register_ret", ok);
            response.getWriter().write(ok);
            request.getRequestDispatcher("register.jsp").forward(request, response);
        }

    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        this.doGet(request, response);
    }
}
