package Servlet;

import Entity.Liutong;
import Service.SearchService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet(
        name = "SearchServlet",
        value = {"/SearchServlet"}
)
public class SearchServlet extends HttpServlet {
    public static final int PAGE_SIZE = 16;  // 每页显示的读者数

    public SearchServlet() {
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String page = request.getParameter("currentPage");
        if (page != null) {
            this.changePage(request, response);  // 分页查询
        } else {
            this.searchLiutong(request, response);  // 搜索功能
        }

        request.getRequestDispatcher("/wangyeyonghu/search.jsp").forward(request, response);
    }



    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        this.doGet(request, response);
    }

    // 分页查询方法
    public void changePage(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        SearchService searchService = new SearchService();
        int currentPage = request.getParameter("currentPage") == null ? 1 : Integer.parseInt(request.getParameter("currentPage"));
        int totalLiutong = searchService.getCurrentListLiutongNum();  // 获取当前查询条件下的总读者数
        int totalPage = (int) Math.ceil((double) totalLiutong / (double) PAGE_SIZE);  // 计算总页数
        if (currentPage > totalPage) {
            currentPage = totalPage;
        }

        if (currentPage < 1) {
            currentPage = 1;
        }

        List<Liutong> liutongList = searchService.getCurrentPage(currentPage);  // 获取当前页的读者列表
        request.setAttribute("liutongList", liutongList);
        request.setAttribute("currentPage", currentPage);
        request.setAttribute("totalPage", totalPage);
    }

    // 搜索功能方法
    public void searchLiutong(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        SearchService searchService = new SearchService();
        String searchField = request.getParameter("searchField");  // 搜索字段（如：readID、name、liutongLevel）
        String searchValue = request.getParameter("searchValue");  // 搜索值（如：某个具体的ID、名字等）
        List<Liutong> liutongList = null;

        if (searchField != null && !searchField.isEmpty() && searchValue != null && !searchValue.isEmpty()) {
            searchService.getSelectLiutong(searchField, searchValue);  // 根据搜索条件查询读者
        } else {
            searchService.getTotalLiutongNum();  // 如果没有搜索条件，获取所有读者数据
        }

        this.changePage(request, response);  // 搜索后分页显示
    }
}
