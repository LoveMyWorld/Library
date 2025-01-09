package Servlet;

import Entity.Dingdan;
import Service.DingdanService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet(
        name = "DingdanServlet",
        value = {"/DingdanServlet"}
)
public class DingdanServlet extends HttpServlet {
    public static final int PAGE_SIZE = 16;  // 每页显示的读者数

    public DingdanServlet() {
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String page = request.getParameter("currentPage");
        if (page != null) {
            this.changePage(request, response);
        }// 分页查询
         else {
            this.searchDingdan(request, response);  // 搜索功能
        }


        request.getRequestDispatcher("/caifang/dingdan.jsp").forward(request, response);
    }



    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        this.doGet(request, response);
    }

    // 分页查询方法
    public void changePage(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        DingdanService dingdanService = new DingdanService();
        int currentPage = request.getParameter("currentPage") == null ? 1 : Integer.parseInt(request.getParameter("currentPage"));
        int totalDingdan = dingdanService.getCurrentListDingdanNum();  // 获取当前查询条件下的总读者数
        int totalPage = (int) Math.ceil((double) totalDingdan / (double) PAGE_SIZE);  // 计算总页数
        if (currentPage > totalPage) {
            currentPage = totalPage;
        }

        if (currentPage < 1) {
            currentPage = 1;
        }

        List<Dingdan> dingdanList = dingdanService.getCurrentPage(currentPage);  // 获取当前页的读者列表
        request.setAttribute("dingdanList", dingdanList);
        request.setAttribute("currentPage", currentPage);
        request.setAttribute("totalPage", totalPage);
    }

    // 搜索功能方法
    public void searchDingdan(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        DingdanService dingdanService = new DingdanService();
//        String searchField = request.getParameter("searchField");  // 搜索字段（如：readID、name、dingdanLevel）
//        String searchValue = request.getParameter("searchValue");  // 搜索值（如：某个具体的ID、名字等）
        List<Dingdan> dingdanList = null;
//
//        if (searchField != null && !searchField.isEmpty() && searchValue != null && !searchValue.isEmpty()) {
//            dingdanService.getSelectDingdan(searchField, searchValue);  // 根据搜索条件查询读者
//        } else {
//            dingdanService.getTotalDingdanNum();  // 如果没有搜索条件，获取所有读者数据
//        }
        dingdanService.getTotalDingdanNum();
        this.changePage(request, response);  // 搜索后分页显示
    }
}


















































//package Servlet;
//import Entity.Caifang;
//import Service.DingdanService;
//import jakarta.servlet.*;
//import jakarta.servlet.http.*;
//import jakarta.servlet.annotation.WebServlet;
//import java.io.IOException;
//import java.util.List;
//
//@WebServlet(name = "DingdanServlet", value = "/DingdanServlet") public class DingdanServlet extends HttpServlet
//{
//    public
//    static final int PAGE_SIZE = 16;
//    @Override protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
//    {
//
//        String page = request.getParameter("currentPage");
//        if(page != null ){ // 需要进行上下页切换
//            changePage(request, response);
//        }
//        else { // 遇到新的搜索条件，默认从第1页起。
//            searchBook(request, response);
//        }
//        request.getRequestDispatcher("/caifang/interview.jsp").forward(request, response);
//    }
//
//    @Override protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
//    {
//        doGet(request, response);
//    }
//
//    public void changePage(HttpServletRequest request , HttpServletResponse response) throws ServletException, IOException{
//        // 分页处理
//        DingdanService dingdanService = new DingdanService();
//        // 当前页面
//        int currentPage = request.getParameter("currentPage") == null ? 1 : Integer.parseInt(request.getParameter("currentPage"));
//        // 获取总记录数
//        int totalbook = dingdanService.getCurrentListBookNum();
//        int totalPage = (int)Math.ceil(totalbook / (double)PAGE_SIZE);
//        // 边界检测
//        if (currentPage > totalPage)
//            currentPage = totalPage;
//        if (currentPage < 1)
//            currentPage = 1;
//        // 获取当前页的数据
//        List<Caifang> caifangList = null;
//        caifangList = dingdanService.getCurrentPage(currentPage);
//        // 传给前端
//        request.setAttribute("caifangList", caifangList);
//        request.setAttribute("currentPage", currentPage);
//        request.setAttribute("totalPage", totalPage);
//    }
//
//    public void searchBook(HttpServletRequest request , HttpServletResponse response) throws ServletException, IOException {
//        DingdanService dingdanService = new DingdanService();
//        String searchField = request.getParameter("searchField");
//        String searchValue = request.getParameter("searchValue");
//        List<Caifang> caifangList = null;
//        // 搜索条件不为空
//        if (searchField != null && !searchField.isEmpty() && searchValue != null && !searchValue.isEmpty())
//        {
//            caifangList=dingdanService.getSelectBook(searchField,searchValue);
//        }
//        else { // 搜索条件为空
//                dingdanService.getTotalBookNum();
//        }
//
//        changePage(request,response);
//    }
//}
