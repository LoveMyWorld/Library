package Servlet.ReturnServlet;

import Entity.ResultInfo;
import Service.ReturnBook.CheckRetBookService;
import com.fasterxml.jackson.databind.ObjectMapper;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.WebServlet;

import java.io.IOException;
import java.io.Writer;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.HashMap;

@WebServlet(name = "CheckRetBookServlet", value = "/CheckRetBookServlet")
public class CheckRetBookServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("application/json;charset=UTF-8");
// 从请求中获取参数
        long bbrID=0;
        String bbrIDString = request.getParameter("bbrID");
        if (bbrIDString != null && !bbrIDString.isEmpty()) {
            bbrID = Long.parseLong(bbrIDString);
        }
        String isDamaged = request.getParameter("isDamaged");
        String isPaid = request.getParameter("isPaid");
        LocalDateTime now = LocalDateTime.now();
        LocalDate currentDate = now.toLocalDate();

        // 将字符串参数转换为布尔值
        boolean isDamagedBool = Boolean.parseBoolean(isDamaged);
        boolean isPaidBool = Boolean.parseBoolean(isPaid);
        int msg=0;
        CheckRetBookService checkRetBookService = new CheckRetBookService();
        msg=checkRetBookService.checkRetBook(bbrID,isDamagedBool,isPaidBool,currentDate);

        // 创建 ResultInfo 对象并设置响应内容
        ResultInfo resultInfo = new ResultInfo();
        resultInfo.setFlag(msg == 4); // 假设 msg 为xxxxxx表示成功，此时flag=true
        if (resultInfo.isFlag()) {
            resultInfo.setErrorMsg("还书成功");
        } else {
            if(msg==1){
                resultInfo.setErrorMsg("借阅记录没有修改成功");
            }
            if(msg==2){
                resultInfo.setErrorMsg("读者信息没有找到");
            }
            if(msg==3){
                resultInfo.setErrorMsg("书籍信息没有找到");
            }

        }

        // 返回 JSON 响应
        sendJsonResponse(response, resultInfo);


    }
    private void sendJsonResponse(HttpServletResponse response, ResultInfo resultInfo) throws IOException {
        HashMap<String, Object> map = new HashMap<>();
        map.put("resultInfo", resultInfo);

        ObjectMapper objectMapper = new ObjectMapper();
        String json = objectMapper.writeValueAsString(map);

        // 使用 Writer 来返回 JSON 响应
        Writer writer = response.getWriter();
        writer.write(json);
        writer.flush();
        writer.close();
    }

}