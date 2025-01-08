package Servlet.adel;

import Dao.TermDicDao;
import Entity.TermDic;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.json.JSONObject;

import java.io.IOException;

@WebServlet("/LookTermDicServlet")
public class LookTermDicServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 设置响应的编码格式
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        // 获取传递的 name 参数
        String term = request.getParameter("term");

        if (term != null && !term.isEmpty()) {
            // 通过 name 从数据库中查询该读者的详细信息
            TermDicDao termDicDao = new TermDicDao();
            TermDic termDic = termDicDao.getTermDicByName(term);

            // 如果找到该读者的信息，返回成功的 JSON 响应
            if (termDic != null) {
                // 创建一个包含读者详细信息的 JSON 对象
                JSONObject jsonResponse = new JSONObject();
                jsonResponse.put("success", true);
                jsonResponse.put("data", new JSONObject()
                        .put("term", termDic.getTerm())
                        .put("def", termDic.getDef()));

                // 返回响应
                response.getWriter().write(jsonResponse.toString());
            } else {
                // 如果没有找到该读者信息，返回错误的 JSON 响应
                JSONObject jsonResponse = new JSONObject();
                jsonResponse.put("success", false);
                jsonResponse.put("message", "未找到该术语信息");
                response.getWriter().write(jsonResponse.toString());
            }
        } else {
            // 如果没有传递 termDicID，返回错误的 JSON 响应
            JSONObject jsonResponse = new JSONObject();
            jsonResponse.put("success", false);
            jsonResponse.put("message", "缺少术语名称");
            response.getWriter().write(jsonResponse.toString());
        }
    }
}