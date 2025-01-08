package Servlet.weihu;

import Dao.PublisherDao;
import Entity.Publisher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.json.JSONObject;

import java.io.IOException;

@WebServlet("/LookPublisherServlet")
public class LookPublisherServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 设置响应的编码格式
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        // 获取传递的 name 参数
        String name = request.getParameter("name");

        if (name != null && !name.isEmpty()) {
            // 通过 name 从数据库中查询该读者的详细信息
            PublisherDao publisherDao = new PublisherDao();
            Publisher publisher = publisherDao.getPublisherByName(name);

            // 如果找到该读者的信息，返回成功的 JSON 响应
            if (publisher != null) {
                // 创建一个包含读者详细信息的 JSON 对象
                JSONObject jsonResponse = new JSONObject();
                jsonResponse.put("success", true);
                jsonResponse.put("data", new JSONObject()
                        .put("name", publisher.getName())
                        .put("addr", publisher.getAddr())
                        .put("contact", publisher.getContact())
                        .put("phoneNum", publisher.getPhoneNum())
                        .put("postcode", publisher.getPostcode()));

                // 返回响应
                response.getWriter().write(jsonResponse.toString());
            } else {
                // 如果没有找到该读者信息，返回错误的 JSON 响应
                JSONObject jsonResponse = new JSONObject();
                jsonResponse.put("success", false);
                jsonResponse.put("message", "未找到该出版社信息");
                response.getWriter().write(jsonResponse.toString());
            }
        } else {
            // 如果没有传递 publisherID，返回错误的 JSON 响应
            JSONObject jsonResponse = new JSONObject();
            jsonResponse.put("success", false);
            jsonResponse.put("message", "缺少名称");
            response.getWriter().write(jsonResponse.toString());
        }
    }
}