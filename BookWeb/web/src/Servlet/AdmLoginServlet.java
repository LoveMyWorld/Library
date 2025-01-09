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
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet(
        name = "AdmLoginServlet",
        value = {"/AdmLoginServlet"}
)
public class AdmLoginServlet extends HttpServlet {
    public AdmLoginServlet() {
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        User user = new User(username, password);
        LoginService loginService = new LoginService();
        String ok = loginService.isCorrect1(user);
        if (ok.equals("true")) {
            HttpSession session = request.getSession();
            session.setAttribute("administrator", user);

            // 检查 username 前五位并跳转到对应页面
            String prefix = username.length() >= 5 ? username.substring(0, 5) : "";
            switch (prefix) {
                case "10000":
                    request.getRequestDispatcher("wangye/manageweb1.jsp").forward(request, response);
                    return;
                case "01000":
                    request.getRequestDispatcher("wangye/manageweb2.jsp").forward(request, response);
                    return;
                case "00100":
                    request.getRequestDispatcher("wangye/manageweb3.jsp").forward(request, response);
                    return;
                case "00010":
                    request.getRequestDispatcher("wangye/manageweb4.jsp").forward(request, response);
                    return;
                case "00001":
                    request.getRequestDispatcher("wangye/manageweb5.jsp").forward(request, response);
                    return;
                default:
                    // 如果没有匹配到特定前缀，跳转到默认主页
                    request.getRequestDispatcher("index.jsp").forward(request, response);
                    return;
            }
        } else {
            request.setAttribute("login_ret", ok);
            response.getWriter().write(ok);
            request.getRequestDispatcher("adm_login.jsp").forward(request, response);
        }

    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        this.doGet(request, response);
    }
}
