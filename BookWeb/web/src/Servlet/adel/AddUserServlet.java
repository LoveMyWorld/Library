package Servlet.adel;


import Dao.UserDao;
import Entity.User;
import Entity.ResultInfo;
import com.fasterxml.jackson.databind.ObjectMapper;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import Service.PasswordSHA256Service;

import java.io.IOException;
import java.io.Writer;
import java.util.HashMap;

@WebServlet("/AddUserServlet")
public class AddUserServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");

        // 从请求中获取参数
        String username = request.getParameter("username");
        String userpwd = request.getParameter("userpwd");

        // 创建 User 对象，先加密密码
        String encryptedPwd = PasswordSHA256Service.encrypt(userpwd);
        User newUser = new User(username, encryptedPwd);

        // 使用 UserDao 保存数据
        UserDao userDao = new UserDao();
        boolean success = userDao.addUser(newUser);

        if (success) {
            ResultInfo resultInfo = new ResultInfo();
            resultInfo.setFlag(true);
            resultInfo.setErrorMsg("提交成功！");
            resultInfo.setData(newUser);
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
