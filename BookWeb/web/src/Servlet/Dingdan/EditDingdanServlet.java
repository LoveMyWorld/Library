package Servlet.Dingdan;


import Dao.DingdanDao;
import Entity.DocumentType;
import Entity.Dingdan;

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

@WebServlet("/EditDingdanServlet")
public class EditDingdanServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");

        // 从请求中获取参数
        String orderName = request.getParameter("orderName");
        String supplier = request.getParameter("supplier");
        String documentType = request.getParameter("documentType");
        String title = request.getParameter("title");
        String publisher = request.getParameter("publisher");
        String orderPerson = request.getParameter("orderPerson");
        String author = request.getParameter("author");
        String ISBN = request.getParameter("ISBN");
        String currencyID = request.getParameter("currencyID");
        String price = request.getParameter("price");
        String edition = request.getParameter("edition");
        String printHouse = request.getParameter("printingHouse");
        String reveiver = request.getSession().getAttribute("receiver").toString();
//        // 转换 birthDay 为 Date 类型
//        Date birthDate = Date.valueOf(birthDay);

        // 创建 Dingdan 对象
//        Dingdan newDingdan = new Dingdan(readID, name, Gender.fromDescription(gender), birthDate, unit, homeAdd, phoneNum, emailAdd, DingdanLevelType.fromDescription(dingdanLevel), Integer.parseInt(creditPoint));
        Dingdan newDingdan = new Dingdan(orderName,supplier,title,publisher,orderPerson,ISBN,DocumentType.fromDescription(documentType),Double.parseDouble(price),Integer.parseInt(currencyID),edition,printHouse,author,false);
        // 使用 DingdanDao 保存数据
        DingdanDao dingdanDao = new DingdanDao();
        newDingdan.setReceiver(reveiver);
        newDingdan.setSubscribeNum(1);


        boolean success = dingdanDao.updateDingdan(newDingdan);

        if (success) {
            ResultInfo resultInfo = new ResultInfo();
            resultInfo.setFlag(true);
            resultInfo.setErrorMsg("提交成功！");
            resultInfo.setData(newDingdan);
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
