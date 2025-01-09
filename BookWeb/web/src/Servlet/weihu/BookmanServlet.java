package Servlet.weihu;

import Entity.Bookman;
import Service.BookmanService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

import static Servlet.Catalog.YanshouServlet.PAGE_SIZE;

@WebServlet(
        name = "BookmanServlet",
        value = {"/BookmanServlet"}
)
public class BookmanServlet extends HttpServlet {
    //public static final int PAGE_SIZE = 16;  // 每页显示的读者数

    public BookmanServlet() {
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String page = request.getParameter("currentPage");
        if (page != null) {
            this.changePage(request, response);  // 分页查询
        } else {
            this.searchBookman(request, response);  // 搜索功能
        }

        request.getRequestDispatcher("/weihu/bookman.jsp").forward(request, response);
    }



    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        this.doGet(request, response);
    }

    // 分页查询方法
    public void changePage(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        BookmanService bookmanService = new BookmanService();
        int currentPage = request.getParameter("currentPage") == null ? 1 : Integer.parseInt(request.getParameter("currentPage"));
        int totalBookman = bookmanService.getCurrentListBookmanNum();  // 获取当前查询条件下的总读者数
        int totalPage = (int) Math.ceil((double) totalBookman / (double) PAGE_SIZE);  // 计算总页数
        if (currentPage > totalPage) {
            currentPage = totalPage;
        }

        if (currentPage < 1) {
            currentPage = 1;
        }

        List<Bookman> bookmanList = bookmanService.getCurrentPage(currentPage);  // 获取当前页的读者列表
        request.setAttribute("bookmanList", bookmanList);
        request.setAttribute("currentPage", currentPage);
        request.setAttribute("totalPage", totalPage);
    }

    // 搜索功能方法
    public void searchBookman(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        BookmanService bookmanService = new BookmanService();
        String searchField = request.getParameter("searchField");  // 搜索字段（如：readID、name、bookmanLevel）
        String searchValue = request.getParameter("searchValue");  // 搜索值（如：某个具体的ID、名字等）
        List<Bookman> bookmanList = null;

        if (searchField != null && !searchField.isEmpty() && searchValue != null && !searchValue.isEmpty()) {
            bookmanService.getSelectBookman(searchField, searchValue);  // 根据搜索条件查询读者
        } else {
            bookmanService.getTotalBookmanNum();  // 如果没有搜索条件，获取所有读者数据
        }

        this.changePage(request, response);  // 搜索后分页显示
    }
}
