package Servlet.adel;

import Dao.ReaderDao;
import Entity.ResultInfo;
import com.fasterxml.jackson.databind.ObjectMapper;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.WebServlet;
import java.io.IOException;
import java.io.Writer;
import java.util.HashMap;


@WebServlet( name = "DeleteReaderServlet2" , value = "/DeleteReaderServlet2")
public class DeleteReaderServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");

        // 从请求中获取参数
        String readID = request.getParameter("readID");

        if (readID == null || readID.isEmpty()) {
            // 如果没有提供readID，返回错误页面
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "读者ID不能为空");
            return;
        }
        // 使用 ReaderDao 保存数据
        ReaderDao readerDao = new ReaderDao();
        boolean success = readerDao.deleteReader(readID);

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

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}
