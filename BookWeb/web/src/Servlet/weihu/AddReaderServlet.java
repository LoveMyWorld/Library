package Servlet.weihu;


import Dao.ReaderDao;
import Entity.Gender;
import Entity.Reader;
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

@WebServlet("/AddReaderServlet")
public class AddReaderServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");

        // 从请求中获取参数
        String readID = request.getParameter("readID");
        String name = request.getParameter("name");
        String gender = request.getParameter("gender");
        String birthDay = request.getParameter("birthDay");
        String unit = request.getParameter("unit");
        String homeAdd = request.getParameter("homeAdd");
        String phoneNum = request.getParameter("phoneNum");
        String emailAdd = request.getParameter("emailAdd");
        String readerLevel = request.getParameter("readerLevel");
        String creditPoint = request.getParameter("creditPoint");

        // 转换 birthDay 为 Date 类型
        Date birthDate = Date.valueOf(birthDay);

        // 创建 Reader 对象
        Reader newReader = new Reader(readID, name, Gender.fromDescription(gender), birthDate, unit, homeAdd, phoneNum, emailAdd, ReaderLevelType.fromDescription(readerLevel), Integer.parseInt(creditPoint));

        // 使用 ReaderDao 保存数据
        ReaderDao readerDao = new ReaderDao();
        boolean success = readerDao.addReader(newReader);

        if (success) {
            ResultInfo resultInfo = new ResultInfo();
            resultInfo.setFlag(true);
            resultInfo.setErrorMsg("提交成功！");
            resultInfo.setData(newReader);
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
