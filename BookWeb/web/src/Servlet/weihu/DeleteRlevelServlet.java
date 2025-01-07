package Servlet.weihu;


import Dao.RlevelDao;
import Entity.Gender;
import Entity.Rlevel;
import Entity.ReaderLevelType;
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

@WebServlet("/DeleteRlevelServlet")
public class DeleteRlevelServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");

        // 从请求中获取参数
        String readerLevel = request.getParameter("readerLevel");

        if (readerLevel == null || readerLevel.isEmpty()) {
            // 如果没有提供readID，返回错误页面
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "读者级别不能为空");
            return;
        }
        // 使用 RlevelDao 保存数据
        RlevelDao rlevelDao = new RlevelDao();
        boolean success = rlevelDao.deleteRlevel(readerLevel);

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
