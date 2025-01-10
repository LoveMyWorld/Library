package Servlet;

import Entity.ResultInfo;
import com.fasterxml.jackson.databind.ObjectMapper;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.WebServlet;

import javax.xml.transform.Result;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;

@WebServlet(name = "IamATest", value = "/IamATest")
public class IamATest extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");

        ResultInfo resultInfo = new ResultInfo();
        resultInfo.setFlag(true);
        HashMap<String , Object> map = new HashMap<>();
        map.put("resultInfo", resultInfo);
        ObjectMapper mapper = new ObjectMapper();
        String json = mapper.writeValueAsString(map);
        PrintWriter out = response.getWriter();
        out.print(json);
        out.flush();
        out.close();

//        request.getRequestDispatcher("/bianmu/damage.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}
