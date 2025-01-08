package Servlet.weihu;


import Dao.PublisherDao;
import Entity.Gender;
import Entity.Publisher;
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

@WebServlet("/AddPublisherServlet")
public class AddPublisherServlet extends HttpServlet {
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

        // 创建 Publisher 对象
        Publisher newPublisher = new Publisher(name, addr, contact, phoneNum, postcode);

        // 使用 PublisherDao 保存数据
        PublisherDao publisherDao = new PublisherDao();
        boolean success = publisherDao.addPublisher(newPublisher);

        if (success) {
            ResultInfo resultInfo = new ResultInfo();
            resultInfo.setFlag(true);
            resultInfo.setErrorMsg("提交成功！");
            resultInfo.setData(newPublisher);
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
