package Servlet.announcement;

import Dao.AnnouncementDao;
import Entity.Announcement;


import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.json.JSONObject;

import java.io.IOException;
import java.io.StringReader;

@WebServlet("/LookAnnouncementServlet")
public class LookAnnouncementServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 设置响应的编码格式
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        // 获取传递的 readID 参数

        String announcementID =request.getParameter("announcementID");

        // 通过 readID 从数据库中查询该读者的详细信息
        AnnouncementDao announcementDao = new AnnouncementDao();


        Announcement announcement = announcementDao.getAnnouncementByID(Integer.parseInt(announcementID));

        // 如果找到该读者的信息，返回成功的 JSON 响应
        if (announcement != null) {
            // 创建一个包含读者详细信息的 JSON 对象
            JSONObject jsonResponse = new JSONObject();
            jsonResponse.put("success", true);
            jsonResponse.put("data", new JSONObject()
                    .put("announcementID", announcement.getAnnouncementID())
                    .put("announcementDate", announcement.getAnnouncementDate())
                    .put("publisher", announcement.getPublisher())
                    .put("announcementText", announcement.getAnnouncementText())
                    .put("announcementKey", announcement.getAnnouncementKey()));


            // 返回响应
            response.getWriter().write(jsonResponse.toString());


        }
    }
    }