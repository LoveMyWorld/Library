//
// Source code recreated from a .class file by IntelliJ IDEA
// (powered by FernFlower decompiler)
//

package Servlet;

import Entity.User;
import Service.LoginService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(
        name = "ReaderLoginServlet",
        value = {"/ReaderLoginServlet"}
)
public class ReaderLoginServlet extends HttpServlet {
    public ReaderLoginServlet() {
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        User user = new User(username, password);
        LoginService loginService = new LoginService();
        String ok = loginService.isCorrect(user);
        if (ok.equals("true")) {
            request.getRequestDispatcher("index.jsp").forward(request, response);
        } else {
            request.setAttribute("login_ret", ok);
            response.getWriter().write(ok);
            request.getRequestDispatcher("reader_login.jsp").forward(request, response);
        }

    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        this.doGet(request, response);
    }
}
