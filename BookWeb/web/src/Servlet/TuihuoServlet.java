package Servlet;

import Entity.Tuihuo;
import Service.TuihuoService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet(
        name = "TuihuoServlet",
        value = {"/TuihuoServlet"}
)
public class TuihuoServlet extends HttpServlet {
    public static final int PAGE_SIZE = 16;  // 每页显示的读者数

    public TuihuoServlet() {
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String page = request.getParameter("currentPage");
        if (page != null) {
            this.changePage(request, response);
        }// 分页查询
        else {
            this.searchTuihuo(request, response);  // 搜索功能
        }


        request.getRequestDispatcher("/caifang/tuihuo.jsp").forward(request, response);
    }



    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        this.doGet(request, response);
    }

    // 分页查询方法
    public void changePage(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        TuihuoService tuihuoService = new TuihuoService();
        int currentPage = request.getParameter("currentPage") == null ? 1 : Integer.parseInt(request.getParameter("currentPage"));
        int totalTuihuo = tuihuoService.getCurrentListTuihuoNum();  // 获取当前查询条件下的总读者数
        int totalPage = (int) Math.ceil((double) totalTuihuo / (double) PAGE_SIZE);  // 计算总页数
        if (currentPage > totalPage) {
            currentPage = totalPage;
        }

        if (currentPage < 1) {
            currentPage = 1;
        }

        List<Tuihuo> tuihuoList = tuihuoService.getCurrentPage(currentPage);  // 获取当前页的读者列表
        request.setAttribute("tuihuoList", tuihuoList);
        request.setAttribute("currentPage", currentPage);
        request.setAttribute("totalPage", totalPage);
    }

    // 搜索功能方法
    public void searchTuihuo(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        TuihuoService tuihuoService = new TuihuoService();
//        String searchField = request.getParameter("searchField");  // 搜索字段（如：readID、name、tuihuoLevel）
//        String searchValue = request.getParameter("searchValue");  // 搜索值（如：某个具体的ID、名字等）
        List<Tuihuo> tuihuoList = null;
//
//        if (searchField != null && !searchField.isEmpty() && searchValue != null && !searchValue.isEmpty()) {
//            tuihuoService.getSelectTuihuo(searchField, searchValue);  // 根据搜索条件查询读者
//        } else {
//            tuihuoService.getTotalTuihuoNum();  // 如果没有搜索条件，获取所有读者数据
//        }
        tuihuoService.getTotalTuihuoNum();
        this.changePage(request, response);  // 搜索后分页显示
    }
}


















































//package Servlet;
//import Entity.Caifang;
//import Service.TuihuoService;
//import jakarta.servlet.*;
//import jakarta.servlet.http.*;
//import jakarta.servlet.annotation.WebServlet;
//import java.io.IOException;
//import java.util.List;
//
//@WebServlet(name = "TuihuoServlet", value = "/TuihuoServlet") public class TuihuoServlet extends HttpServlet
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
//        TuihuoService tuihuoService = new TuihuoService();
//        // 当前页面
//        int currentPage = request.getParameter("currentPage") == null ? 1 : Integer.parseInt(request.getParameter("currentPage"));
//        // 获取总记录数
//        int totalbook = tuihuoService.getCurrentListBookNum();
//        int totalPage = (int)Math.ceil(totalbook / (double)PAGE_SIZE);
//        // 边界检测
//        if (currentPage > totalPage)
//            currentPage = totalPage;
//        if (currentPage < 1)
//            currentPage = 1;
//        // 获取当前页的数据
//        List<Caifang> caifangList = null;
//        caifangList = tuihuoService.getCurrentPage(currentPage);
//        // 传给前端
//        request.setAttribute("caifangList", caifangList);
//        request.setAttribute("currentPage", currentPage);
//        request.setAttribute("totalPage", totalPage);
//    }
//
//    public void searchBook(HttpServletRequest request , HttpServletResponse response) throws ServletException, IOException {
//        TuihuoService tuihuoService = new TuihuoService();
//        String searchField = request.getParameter("searchField");
//        String searchValue = request.getParameter("searchValue");
//        List<Caifang> caifangList = null;
//        // 搜索条件不为空
//        if (searchField != null && !searchField.isEmpty() && searchValue != null && !searchValue.isEmpty())
//        {
//            caifangList=tuihuoService.getSelectBook(searchField,searchValue);
//        }
//        else { // 搜索条件为空
//                tuihuoService.getTotalBookNum();
//        }
//
//        changePage(request,response);
//    }
//}
