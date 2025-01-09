package Servlet.Dingdan;


import Dao.DingdanDao;
import Entity.Gender;
import Entity.Dingdan;

import Entity.ResultInfo;
import com.fasterxml.jackson.databind.ObjectMapper;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.Writer;
import java.sql.Date;
import java.util.HashMap;

@WebServlet("/DeleteDingdanServlet")
public class DeleteDingdanServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");

        // 从请求中获取参数
        String orderName = request.getParameter("orderName");

        if (orderName == null || orderName.isEmpty()) {
            // 如果没有提供readID，返回错误页面
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "订单号不能为空");
            return;
        }
        // 使用 DingdanDao 保存数据
        DingdanDao dingdanDao = new DingdanDao();
        boolean success = dingdanDao.deleteDingdan(orderName);

        if (success) {
            ResultInfo resultInfo = new ResultInfo();
            resultInfo.setFlag(true);
            resultInfo.setErrorMsg("删除成功！");
            HashMap<String,Object> map = new HashMap<>();
            map.put("resultInfo",resultInfo);

            ObjectMapper objectMapper = new ObjectMapper();
            String json = objectMapper.writeValueAsString(map);

            Writer writer = response.getWriter();
            writer.write(json);
            writer.flush();
            writer.close();
        } else {
            response.getWriter().write("Failed");
        }
    }
}
