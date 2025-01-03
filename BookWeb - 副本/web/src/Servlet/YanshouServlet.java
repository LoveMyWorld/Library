package Servlet;
import Dao.YanshouDao;
import Entity.Yanshou;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.WebServlet;

import java.io.IOException;
import java.util.List;

@WebServlet( name = "YanshouServlet" , value = "/YanshouServlet")
public class YanshouServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        YanshouDao yanshouDao = new YanshouDao();
        List<Yanshou> yanshouList = null;
        try {
            // 查询所有数据
            yanshouList = yanshouDao.getAllData();
        } catch (Exception e) {
            e.printStackTrace(); // 打印错误日志
        }
        //得到身份
        HttpSession session = request.getSession();
        request.setAttribute("yanshouList", yanshouList);
        request.getRequestDispatcher("bianmu/yanshou.jsp").forward(request, response);

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
