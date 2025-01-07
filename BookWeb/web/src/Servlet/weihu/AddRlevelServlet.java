package Servlet.weihu;


import Dao.RlevelDao;
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
import java.util.HashMap;

@WebServlet("/AddRlevelServlet")
public class AddRlevelServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");

        // 从请求中获取参数
        String readerLevel = request.getParameter("readerLevel");
        String creditPointRange = request.getParameter("creditPointRange");
        String borrowNum = request.getParameter("borrowNum");
        String borrowDay = request.getParameter("borrowDay");
        String orderNum = request.getParameter("orderNum");
        String orderDay = request.getParameter("orderDay");
        String fineEveryday = request.getParameter("fineEveryday");

        // 创建 Rlevel 对象
        Rlevel newRlevel = new Rlevel(ReaderLevelType.fromDescription(readerLevel), creditPointRange, Integer.parseInt(borrowNum), Integer.parseInt(borrowDay), Integer.parseInt(orderNum), Integer.parseInt(orderDay), Float.parseFloat(fineEveryday));

        // 使用 RlevelDao 保存数据
        RlevelDao rlevelDao = new RlevelDao();
        boolean success = rlevelDao.addRlevel(newRlevel);

        if (success) {
            ResultInfo resultInfo = new ResultInfo();
            resultInfo.setFlag(true);
            resultInfo.setErrorMsg("提交成功！");
            resultInfo.setData(newRlevel);
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
