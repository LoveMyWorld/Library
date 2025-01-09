package Servlet.adel;

import Dao.RlevelDao;
import Entity.Rlevel;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.json.JSONObject;

import java.io.IOException;

@WebServlet("/LookRlevelServlet")
public class LookRlevelServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 设置响应的编码格式
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        // 获取传递的 readerLevel 参数
        String readerLevel = request.getParameter("readerLevel");

        if (readerLevel != null && !readerLevel.isEmpty()) {
            // 通过 readID 从数据库中查询该读者的详细信息
            RlevelDao rlevelDao = new RlevelDao();
            Rlevel rlevel = rlevelDao.getRlevelByRlevel(readerLevel);

            // 如果找到该读者的信息，返回成功的 JSON 响应
            if (rlevel != null) {
                // 创建一个包含读者详细信息的 JSON 对象
                JSONObject jsonResponse = new JSONObject();
                jsonResponse.put("success", true);
                jsonResponse.put("data", new JSONObject()
                        .put("readerLevel", rlevel.getReaderLevel().getDescription())
                        .put("creditPointRange", rlevel.getCreditPointRange())
                        .put("borrowNum", rlevel.getBorrowNum())
                        .put("borrowDay", rlevel.getBorrowDay())
                        .put("orderNum", rlevel.getOrderNum())
                        .put("orderDay", rlevel.getOrderDay())
                        .put("fineEveryday", rlevel.getFineEveryday()));

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
            // 如果没有传递 readerLevel，返回错误的 JSON 响应
            JSONObject jsonResponse = new JSONObject();
            jsonResponse.put("success", false);
            jsonResponse.put("message", "缺少读者编号");
            response.getWriter().write(jsonResponse.toString());
        }
    }
}