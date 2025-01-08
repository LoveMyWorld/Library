package Servlet.adel;

import Dao.ReaderDao;
import Entity.Reader;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.json.JSONObject;

import java.io.IOException;

@WebServlet("/LookReaderServlet")
public class LookReaderServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 设置响应的编码格式
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        // 获取传递的 readID 参数
        String readID = request.getParameter("readID");

        if (readID != null && !readID.isEmpty()) {
            // 通过 readID 从数据库中查询该读者的详细信息
            ReaderDao readerDao = new ReaderDao();
            Reader reader = readerDao.getReaderByID(readID);

            // 如果找到该读者的信息，返回成功的 JSON 响应
            if (reader != null) {
                // 创建一个包含读者详细信息的 JSON 对象
                JSONObject jsonResponse = new JSONObject();
                jsonResponse.put("success", true);
                jsonResponse.put("data", new JSONObject()
                        .put("readID", reader.getReadID())
                        .put("name", reader.getName())
                        .put("gender", reader.getGender().getDescription())
                        .put("birthDay", reader.getBirthDay())
                        .put("unit", reader.getUnit())
                        .put("homeAdd", reader.getHomeAdd())
                        .put("phoneNum", reader.getPhoneNum())
                        .put("emailAdd", reader.getEmailAdd())
                        .put("readerLevel", reader.getReaderLevel().getDescription())
                        .put("creditPoint", reader.getCreditPoint()));

                // 返回响应
                response.getWriter().write(jsonResponse.toString());
            } else {
                // 如果没有找到该读者信息，返回错误的 JSON 响应
                JSONObject jsonResponse = new JSONObject();
                jsonResponse.put("success", false);
                jsonResponse.put("message", "未找到该读者信息");
                response.getWriter().write(jsonResponse.toString());
            }
        } else {
            // 如果没有传递 readerID，返回错误的 JSON 响应
            JSONObject jsonResponse = new JSONObject();
            jsonResponse.put("success", false);
            jsonResponse.put("message", "缺少读者编号");
            response.getWriter().write(jsonResponse.toString());
        }
    }
}