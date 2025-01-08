package Servlet.BorrowServlet;

import Entity.DisplayBorrowBookMsg;
import Entity.ResultInfo;
import Service.Borrow.DirBorrowSevice;
import com.fasterxml.jackson.databind.ObjectMapper;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.WebServlet;

import java.io.IOException;
import java.io.Writer;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.HashMap;
//读者信息和书籍回填
@WebServlet(name = "DisplayMsgServlet", value = "/DisplayMsgServlet")
public class DisplayMsgServlet extends HttpServlet {
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
        HashMap<String, Object> map = new HashMap<>();
        int msg=0;//获取读者或书籍信息失败
        DirBorrowSevice dirBorrowSevice = new DirBorrowSevice();
        DisplayBorrowBookMsg displayBorrowBookMsg =dirBorrowSevice.dispalyBorrowBook(readID,bookID);
        msg=displayBorrowBookMsg.getMsg();
        // 创建 ResultInfo 对象并设置响应内容
        ResultInfo resultInfo = new ResultInfo();
        resultInfo.setFlag(msg == 1 ); // 假设 msg 为xxxxxx表示成功，此时flag=true
        if (resultInfo.isFlag()) {
            resultInfo.setErrorMsg("展示成功，请核对");

            map.put("name", displayBorrowBookMsg.getName());
            map.put("gender", displayBorrowBookMsg.getGender());
            map.put("phoneNum", displayBorrowBookMsg.getPhoneNum());
            map.put("title", displayBorrowBookMsg.getTitle());
            map.put("author", displayBorrowBookMsg.getAuthor());
            map.put("edition",displayBorrowBookMsg.getEdition());

        } else {
            if(msg==2){
                resultInfo.setErrorMsg("获取书籍信息失败，确认有无该书籍");
            }
            if(msg==3){
                resultInfo.setErrorMsg("获取读者失败，确认有无该读者");
            }


        }

        // 返回 JSON 响应

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
