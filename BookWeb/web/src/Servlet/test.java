//package Servlet;
//
//import Dao.Dao;
//import Entity.Cataloglist;
//import Entity.Gender;
//import Entity.ResultInfo;
//import Entity.WeiGui;
//import com.fasterxml.jackson.databind.ObjectMapper;
//import jakarta.servlet.*;
//import jakarta.servlet.http.*;
//import jakarta.servlet.*;
//
//import java.io.IOException;
//import java.io.PrintWriter;
//import java.sql.PreparedStatement;
//import java.sql.ResultSet;
//import java.sql.SQLException;
//import java.util.ArrayList;
//import java.util.HashMap;
//import java.util.List;
//
//import jakarta.servlet.annotation.WebServlet;
//
//@WebServlet(name = "test", value = "/test")
//public class test extends HttpServlet {
//    @Override
//    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//
//        request.setCharacterEncoding("UTF-8");
//        response.setCharacterEncoding("UTF-8");
//        response.setContentType("text/html;charset=UTF-8");
//
//        // 返回数据
//        // 准备数据
//        ResultInfo resultInfo = new ResultInfo();
//        resultInfo.setFlag(true);
//        resultInfo.setData("hhh");
//        resultInfo.setErrorMsg("成功了");
//
//        // 形成json格式
//        HashMap<String , Object> map = new HashMap<>();
//        map.put("resultInfo", resultInfo);
//        map.put("username" , "HAndsomerun");
//        map.put("book" , new Cataloglist());
//        ObjectMapper mapper = new ObjectMapper();
//        String json = mapper.writeValueAsString(map);
//
//        // 发送数据
//        PrintWriter out = response.getWriter();
//        out.println(json);
//        out.flush();
//        out.close();
//    }
//
//    @Override
//    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//
//    }
//}
//
//
//
//
//public List<WeiGui> getLastTenLines() {
//    String sql ="SELECT * FROM library.weigui\n" +
//            "ORDER BY    weiguiID DESC\n" +
//            "LIMIT 10";
//
//    Dao dao = new Dao();
//    List<WeiGui> dataList = new ArrayList<>();
//    try{
//        PreparedStatement ps =dao.conn.prepareStatement(sql);
//        ResultSet rs = ps.executeQuery();
//
//        while (rs.next()) {
//
//            WeiGui weigui = new WeiGui();
//            weigui.setWeiguiID(rs.getInt("weiguiID"));
//            weigui.setName(rs.getString("name"));
//            String t = rs.getString("gender");
//            weigui.setGender(Gender.fromDescription(t));
//            weigui.setReadID(rs.getString("readID"));
//            weigui.setBadContent(rs.getString("badContent"));
//
//
//
//
//            dataList.add(weigui);
//
//        }
//
//        dao.AllClose();
//        return dataList;
//
//
//
//    } catch (SQLException e) {
//        throw new RuntimeException(e);
//    }
//
//
//
//}
