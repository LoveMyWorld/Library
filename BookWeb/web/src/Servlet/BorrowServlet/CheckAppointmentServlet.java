package Servlet.BorrowServlet;

import Entity.ResultInfo;
import Service.AppointmentService;
import com.fasterxml.jackson.databind.ObjectMapper;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.WebServlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.io.Writer;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;

@WebServlet(name = "CheckAppointmentServlet", value = "/CheckAppointmentServlet")
public class CheckAppointmentServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//        request.getRequestDispatcher("/liutong/DirBorrow.jsp").forward(request, response);
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("application/json;charset=UTF-8");

        // 从请求中获取参数
        String apIDStr = request.getParameter("apID");

        LocalDateTime now = LocalDateTime.now();
        LocalDate currentDate = now.toLocalDate();
        long apID = 0;

        if (apIDStr != null && !apIDStr.isEmpty()) {
            try {
                apID = Long.parseLong(apIDStr);
            } catch (NumberFormatException e) {
                System.out.println("Invalid apID: " + apIDStr);
                // 返回错误响应
                sendErrorResponse(response, "无效的预约号");
                return;
            }
        } else {
            System.out.println("apID is null or empty");
            // 返回错误响应
            sendErrorResponse(response, "预约号为空");
            return;
        }

        // 调用 AppointmentService 来进行审核
        AppointmentService appointmentService = new AppointmentService();
        int msg = appointmentService.CheckOneAppointment(apID, currentDate);

        // 创建 ResultInfo 对象并设置响应内容
        ResultInfo resultInfo = new ResultInfo();
        resultInfo.setFlag(msg == 4); // 假设 msg 为 4 表示成功
        if (resultInfo.isFlag()) {
            resultInfo.setErrorMsg("审核成功");
        } else {
            if(msg==0){
                resultInfo.setErrorMsg("没有找到预约表中的记录");
            }
            if(msg==1){
                resultInfo.setErrorMsg("流通库表没书了");
            }
            if(msg==2){
                resultInfo.setErrorMsg("没有写入预约表，操作失误");
            }
            if(msg==3){
                resultInfo.setErrorMsg("预约内容未删去");
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

    private void sendErrorResponse(HttpServletResponse response, String errorMsg) throws IOException {
        ResultInfo resultInfo = new ResultInfo();
        resultInfo.setFlag(false);
        resultInfo.setErrorMsg(errorMsg);

        // 返回错误响应
        sendJsonResponse(response, resultInfo);
    }
}