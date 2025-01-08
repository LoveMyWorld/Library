package Servlet.BorrowServlet;

import Entity.ResultInfo;
import Service.DirBorrowSevice;
import com.fasterxml.jackson.databind.ObjectMapper;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.WebServlet;

import java.io.IOException;
import java.io.Writer;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.HashMap;

@WebServlet(name = "DirBorrowServlet", value = "/DirBorrowServlet")
public class DirBorrowServlet extends HttpServlet {
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
        String readID = request.getParameter("readID");
        String bookID = request.getParameter("bookID");
        LocalDateTime now = LocalDateTime.now();
        LocalDate currentDate = now.toLocalDate();
        int msg=0;
        DirBorrowSevice dirBorrowSevice = new DirBorrowSevice();
        msg=dirBorrowSevice.checkDirBorrow(readID,bookID,currentDate);

        // 创建 ResultInfo 对象并设置响应内容
        ResultInfo resultInfo = new ResultInfo();
        resultInfo.setFlag(msg == 5 ); // 假设 msg 为xxxxxx表示成功，此时flag=true
        if (resultInfo.isFlag()) {
            resultInfo.setErrorMsg("借书成功");
        } else {
            if(msg==1){
                resultInfo.setErrorMsg("读者不存在或者读者是黑名单用户");
            }
            if(msg==2){
                resultInfo.setErrorMsg("没有多余的可借书");
            }
            if(msg==3){
                resultInfo.setErrorMsg("有书可借给读者，但流通库表没有更新成功");
            }
            if(msg==4){
                resultInfo.setErrorMsg("该借阅登记未正常写入借阅记录");
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
