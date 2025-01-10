package Servlet.Dingdan;

import Dao.DingdanDao;
import Entity.Dingdan;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.json.JSONObject;

import java.io.IOException;

@WebServlet("/LookDingdanServlet")
public class LookDingdanServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 设置响应的编码格式
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        // 获取传递的 readID 参数                                                                                                      (?为什么好了
        String orderName = request.getParameter("orderName");

        if (orderName != null && !orderName.isEmpty()) {
            // 通过 readID 从数据库中查询该读者的详细信息
            DingdanDao dingdanDao = new DingdanDao();
            Dingdan dingdan = dingdanDao.getDingdanByID(orderName);

            // 如果找到该读者的信息，返回成功的 JSON 响应
            if (dingdan != null) {
                HttpSession session = request.getSession();
                session.setAttribute("receiver", dingdan.getReceiver());

                // 创建一个包含读者详细信息的 JSON 对象
                JSONObject jsonResponse = new JSONObject();
                jsonResponse.put("success", true);
                jsonResponse.put("data", new JSONObject()
                                .put("orderName", dingdan.getOrderName())
                                .put("supplier", dingdan.getSupplier())
                                .put("documentType", dingdan.getDocumentType().getDescription())
                                .put("title", dingdan.getTitle())
                                .put("publisher", dingdan.getPublisher())
                                .put("orderPerson", dingdan.getOrderPerson())
                                .put("author", dingdan.getAuthor())
                                .put("ISBN", dingdan.getISBN())
                                .put("currencyID", dingdan.getCurrencyID())
                                .put("price", dingdan.getPrice())
                                .put("edition", dingdan.getEdition())
                                .put("printingHouse", dingdan.getPrintingHouse()));




                // 返回响应
                response.getWriter().write(jsonResponse.toString());
            } else {
                // 如果没有找到该读者信息，返回错误的 JSON 响应
                JSONObject jsonResponse = new JSONObject();
                jsonResponse.put("success", false);
                jsonResponse.put("message", "未找到该订单信息");
                response.getWriter().write(jsonResponse.toString());
            }
        } else {
            // 如果没有传递 dingdanID，返回错误的 JSON 响应
            JSONObject jsonResponse = new JSONObject();
            jsonResponse.put("success", false);
            jsonResponse.put("message", "缺少订单编号");
            response.getWriter().write(jsonResponse.toString());
        }
    }
}