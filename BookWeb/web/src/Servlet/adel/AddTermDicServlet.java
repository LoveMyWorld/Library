package Servlet.adel;


import Dao.TermDicDao;
import Entity.TermDic;
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

@WebServlet("/AddTermDicServlet")
public class AddTermDicServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");

        // 从请求中获取参数
        String term = request.getParameter("term");
        String def = request.getParameter("def");

        // 创建 TermDic 对象
        TermDic newTermDic = new TermDic(term, def);

        // 使用 TermDicDao 保存数据
        TermDicDao termDicDao = new TermDicDao();
        boolean success = termDicDao.addTermDic(newTermDic);

        if (success) {
            ResultInfo resultInfo = new ResultInfo();
            resultInfo.setFlag(true);
            resultInfo.setErrorMsg("提交成功！");
            resultInfo.setData(newTermDic);
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
