package Servlet.adel;


import Dao.BookmanDao;
import Entity.Bookman;
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

@WebServlet("/AddBookmanServlet")
public class AddBookmanServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");

        // 从请求中获取参数
        String name = request.getParameter("name");
        String addr = request.getParameter("addr");
        String contact = request.getParameter("contact");
        String phoneNum = request.getParameter("phoneNum");
        String postcode = request.getParameter("postcode");

        // 创建 Bookman 对象
        Bookman newBookman = new Bookman(name, addr, contact, phoneNum, postcode);

        // 使用 BookmanDao 保存数据
        BookmanDao bookmanDao = new BookmanDao();
        boolean success = bookmanDao.addBookman(newBookman);

        if (success) {
            ResultInfo resultInfo = new ResultInfo();
            resultInfo.setFlag(true);
            resultInfo.setErrorMsg("提交成功！");
            resultInfo.setData(newBookman);
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
